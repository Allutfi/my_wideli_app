import 'package:wideli/after_login/tas_page.dart';
import 'package:wideli/menu/detailpage_byon.dart';
import 'package:flutter/material.dart';
import 'base_menu_item.dart';

class Byon extends StatelessWidget {
  const Byon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kantin B. Yon',
      home: const MenuList(),
    );
  }
}

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: kToolbarHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.6,
                  child: Image.network(
                    'https://shorturl.at/bTgpb',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kantin B. Yon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: const [
          MenuCategory(
            title: 'Makanan',
            items: [
              MenuItem(
                name: 'Bakso Porsi Kuli',
                price: 'Rp. 20.000',
                rating: '4.7',
                imageUrl: 'https://shorturl.at/KfsNM',
                addOns: ['Pedas', 'Sedang'],
              ),
              MenuItem(
                name: 'Bakso Porsi Normal',
                price: 'Rp. 10.000',
                rating: '4.8',
                imageUrl: 'https://shorturl.at/7XLYr',
                addOns: ['Pedas', 'Sedang'],
              ),
              MenuItem(
                name: 'Bakso Porsi Sedang',
                price: 'Rp. 7.000',
                rating: '4.7',
                imageUrl: 'https://shorturl.at/SPQMj',
                addOns: ['Pedas', 'Sedang'],
              ),
              MenuItem(
                name: 'Cilot',
                price: 'Rp. 5.000',
                rating: '4.5',
                imageUrl: 'https://shorturl.at/wVHpv',
                addOns: ['Pedas', 'Sedang'],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuCategory extends StatelessWidget {
  final String title;
  final List<MenuItem> items;

  const MenuCategory({Key? key, required this.title, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        ...items.map((item1) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(menuItem1: item1),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item1.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item1.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text(item1.price,
                              style: const TextStyle(color: Colors.grey)),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(item1.rating),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            )),
        const Divider(),
      ],
    );
  }
}

class MenuItem extends BaseMenuItem {
  const MenuItem({
    required super.name,
    required super.price,
    required super.rating,
    required super.imageUrl,
    super.addOns = const [],
  });
}
