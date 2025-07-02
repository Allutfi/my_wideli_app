import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wideli/after_login/cart_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orders = cartProvider.orders;

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Pesanan')),
      body: orders.isEmpty
          ? const Center(child: Text("Belum ada pesanan"))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailScreen(orderId: order.id),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pesanan #${order.id.substring(order.id.length - 4)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Chip(
                                label: Text(order.status),
                                backgroundColor: _getStatusColor(order.status),
                              ),
                            ],
                          ),
                          Text(
                            '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year} ${order.orderDate.hour}:${order.orderDate.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${order.items.length} Item • Total: Rp ${_formatCurrency(order.total + order.deliveryFee)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diproses':
        return Colors.orange[100]!;
      case 'Selesai':
        return Colors.green[100]!;
      case 'Dibatalkan':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final Order order =
        cartProvider.orders.firstWhere((o) => o.id == widget.orderId);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Detail Pesanan #${order.id.substring(order.id.length - 4)}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status Pesanan',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Chip(
                          label: Text(order.status),
                          backgroundColor: _getStatusColor(order.status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tanggal: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year} ${order.orderDate.hour}:${order.orderDate.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    _buildPriceDetail(order),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Item Pesanan (${order.items.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.menuItem.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: const Icon(Icons.fastfood),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.menuItem.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${item.quantity}x Rp ${_formatCurrency(double.parse(item.menuItem.price.replaceAll(RegExp(r'[^0-9]'), '')))}',
                              ),
                              if (item.selectedAddOns.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Tambahan: ${item.selectedAddOns.join(', ')}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                              if (item.note.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Catatan: ${item.note}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                              const SizedBox(height: 4),
                              Text(
                                'Kantin: ${item.kantin}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            if (order.status == 'Diproses')
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Batalkan Pesanan'),
                      content: const Text(
                          'Apakah Anda yakin ingin membatalkan pesanan ini?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () {
                            cartProvider.cancelOrderById(order.id);
                            Navigator.pop(context);
                            setState(() {}); // trigger rebuild
                          },
                          child: const Text('Ya'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Batalkan Pesanan'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceDetail(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subtotal Item:'),
            Text('Rp ${_formatCurrency(order.total)}'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ongkos Kirim:'),
            Text('Rp ${_formatCurrency(order.deliveryFee)}'),
          ],
        ),
        const Divider(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Pembayaran:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Rp ${_formatCurrency(order.total + order.deliveryFee)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diproses':
        return Colors.orange[100]!;
      case 'Selesai':
        return Colors.green[100]!;
      case 'Dibatalkan':
        return Colors.red[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}
