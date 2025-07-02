import 'package:wideli/after_login/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<int, bool> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    if (selectedItems.isEmpty && cartItems.isNotEmpty) {
      selectedItems = {for (var i = 0; i < cartItems.length; i++) i: false};
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text("Keranjang kosong"))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: Checkbox(
                            value: selectedItems[index] ?? false,
                            onChanged: (value) {
                              setState(() {
                                selectedItems[index] = value!;
                              });
                            },
                          ),
                          title: Text(item.menuItem.name),
                          subtitle: Text(
                            'Jumlah: ${item.quantity}\n'
                            'Tambahan: ${item.selectedAddOns.join(', ')}\n'
                            'Catatan: ${item.note}\n'
                            'Kantin: ${item.kantin}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  cartProvider.removeFromCart(index);
                                  setState(() {
                                    selectedItems.remove(index);
                                    selectedItems = {
                                      for (var i = 0;
                                          i < cartProvider.items.length;
                                          i++)
                                        i: selectedItems[i] ?? false
                                    };
                                  });
                                },
                              ),
                              Image.network(
                                item.menuItem.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  final selectedIndices = selectedItems.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();

                  if (selectedIndices.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Pilih setidaknya satu item untuk dipesan'),
                      ),
                    );
                    return;
                  }

                  final selectedCartItems =
                      selectedIndices.map((index) => cartItems[index]).toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        items: selectedCartItems,
                        cartProvider: cartProvider,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  final List<CartItem> items;
  final CartProvider cartProvider;

  const CheckoutPage({
    Key? key,
    required this.items,
    required this.cartProvider,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _deliveryOption = 'standar';
  String _customerName = 'Pengguna';
  double _deliveryFee = 10000.0;

  double parsePrice(String priceStr) {
    // Hapus semua karakter non-digit
    String cleaned = priceStr.replaceAll(RegExp(r'[^\d]'), '');
    return double.parse(cleaned.isEmpty ? '0' : cleaned);
  }

  double getTotalPrice() {
    return widget.items.fold(
      0.0,
      (sum, item) => sum + (parsePrice(item.menuItem.price) * item.quantity),
    );
  }

  void _updateDeliveryOption(String value) {
    setState(() {
      _deliveryOption = value;
      _deliveryFee = _calculateDeliveryFee(value); // Update ongkir
    });
  }

  double _calculateDeliveryFee(String option) {
    switch (option) {
      case 'prioritas':
        return 15000.0;
      case 'standar':
        return 10000.0;
      case 'hemat':
        return 5000.0;
      default:
        return 10000.0;
    }
  }

  String formatCurrency(double amount) {
    // Format dengan titik sebagai pemisah ribuan
    String result = amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return 'Rp $result';
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = getTotalPrice();
    final deliveryFee = _deliveryFee;
    final grandTotal = totalPrice + deliveryFee;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Pesanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pemesan: $_customerName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pesanan Anda:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  final price = parsePrice(item.menuItem.price);
                  final totalItemPrice = price * item.quantity;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Tambahkan gambar menu
                          Image.network(
                            item.menuItem.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.fastfood, size: 60),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.menuItem.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text('Kantin: ${item.kantin}'),
                                Text('Jumlah: ${item.quantity}'),
                                if (item.selectedAddOns.isNotEmpty)
                                  Text(
                                      'Tambahan: ${item.selectedAddOns.join(', ')}'),
                                if (item.note.isNotEmpty)
                                  Text('Catatan: ${item.note}'),
                              ],
                            ),
                          ),
                          Text(
                            formatCurrency(totalItemPrice),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            const Text(
              'Pilihan Pengantaran:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Prioritas (15 menit)'),
                  subtitle: Text(formatCurrency(15000.0)),
                  value: 'prioritas',
                  groupValue: _deliveryOption,
                  onChanged: (value) {
                    setState(() {
                      _updateDeliveryOption(value!);
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Standar (30 menit)'),
                  subtitle: Text(formatCurrency(10000.0)),
                  value: 'standar',
                  groupValue: _deliveryOption,
                  onChanged: (value) {
                    setState(() {
                      _updateDeliveryOption(value!);
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Hemat (45-60 menit)'),
                  subtitle: Text(formatCurrency(5000.0)),
                  value: 'hemat',
                  groupValue: _deliveryOption,
                  onChanged: (value) {
                    setState(() {
                      _updateDeliveryOption(value!);
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal:'),
                Text(formatCurrency(totalPrice)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ongkos Kirim:'),
                Text(formatCurrency(_deliveryFee)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  formatCurrency(grandTotal),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () async {
                try {
                  // Create the order first
                  widget.cartProvider.createOrder(
                    widget.items,
                    deliveryFee: _deliveryFee,
                    deliveryOption: _deliveryOption,
                  );

                  // Then remove the ordered items from cart
                  final selectedIndices = widget.items
                      .map((item) => widget.cartProvider.items.indexOf(item))
                      .where((index) => index != -1)
                      .toList()
                      .reversed
                      .toList(); // Reverse to avoid index shifting

                  for (var index in selectedIndices) {
                    if (index != -1) {
                      widget.cartProvider.removeFromCart(index);
                    }
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pesanan berhasil dikirim!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal membuat pesanan: $e'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text(
                'Konfirmasi Pesanan',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
