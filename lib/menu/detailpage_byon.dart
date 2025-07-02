import 'package:wideli/after_login/cart_model.dart';
import 'package:wideli/after_login/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'menub_yon.dart';

class DetailPage extends StatefulWidget {
  final MenuItem menuItem1;

  const DetailPage({Key? key, required this.menuItem1}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  Map<String, bool> selectedAddOns = {};
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var addOn in widget.menuItem1.addOns) {
      selectedAddOns[addOn] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.menuItem1.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(widget.menuItem1.imageUrl,
              width: double.infinity, height: 200, fit: BoxFit.cover),
          const SizedBox(height: 16),
          Text(widget.menuItem1.name,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(widget.menuItem1.price,
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Row(children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 4),
            Text(widget.menuItem1.rating, style: const TextStyle(fontSize: 16)),
          ]),
          const SizedBox(height: 16),
          const Text("Jumlah",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                if (quantity > 1) setState(() => quantity--);
              },
            ),
            Text('$quantity', style: const TextStyle(fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => setState(() => quantity++),
            ),
          ]),
          if (widget.menuItem1.addOns.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text("Tambahan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...widget.menuItem1.addOns.map((addOn) => CheckboxListTile(
                  title: Text(addOn),
                  value: selectedAddOns[addOn],
                  onChanged: (value) =>
                      setState(() => selectedAddOns[addOn] = value!),
                )),
          ],
          const SizedBox(height: 16),
          const Text("Catatan Untuk Penjual",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextField(
            controller: noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText:
                  "Permintaanmu akan disesuaikan dengan kebijakan penjual.",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                final selectedAddOnsList = selectedAddOns.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();

                final cartItem = CartItem(
                  menuItem: widget.menuItem1, // Ini adalah yon.MenuItem
                  quantity: quantity,
                  selectedAddOns: selectedAddOnsList,
                  note: noteController.text,
                  kantin: "Kantin B. Yon", // Identifikasi kantin
                );

                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(cartItem);

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Ditambahkan ke keranjang!"),
                ));
              },
              child: const Text("Masukkan Keranjang",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}
