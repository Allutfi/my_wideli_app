import 'package:flutter/material.dart';
import 'package:wideli/after_login/tas_page.dart';
import 'base_menu_item.dart';
import 'detailpage_karyanusa.dart';

class Knusa extends StatelessWidget {
  const Knusa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karya Nusa',
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
                    'https://shorturl.at/tlqL1',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Karya Nusa',
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
            title: 'Jasa',
            items: [
              MenuItem(
                name: 'Jasa Print',
                price: 'Rp. 1.000',
                rating: '4.2',
                imageUrl: 'https://shorturl.at/czXOx',
                addOns: ['Putih', 'Merah', 'Kuning', 'Biru'],
              ),
              MenuItem(
                name: 'Jasa Fotocopy',
                price: 'Rp. 5.00',
                rating: '4.3',
                imageUrl: 'https://shorturl.at/LNwic',
                addOns: [],
              ),
              MenuItem(
                name: 'Jilid Lakban',
                price: 'Rp. 5.000',
                rating: '4.6',
                imageUrl: 'https://shorturl.at/6KCJX',
                addOns: ['Putih', 'Merah', 'Kuning', 'Biru'],
              ),
              MenuItem(
                name: 'Alat Tulis Kantor',
                price: 'Rp. 2.000',
                rating: '4.4',
                imageUrl: 'https://shorturl.at/kCHHd',
                addOns: [
                  'Kertas',
                  'Bolpoin',
                  'Pensil',
                  'Penghapus',
                  'Penggaris',
                  'Map',
                  'Lainnya'
                ],
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
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(menuItem3: item),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imageUrl,
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
                          Text(item.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text(item.price,
                              style: const TextStyle(color: Colors.grey)),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(item.rating),
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
