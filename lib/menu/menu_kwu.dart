import 'package:wideli/after_login/tas_page.dart';
import 'package:flutter/material.dart';
import 'base_menu_item.dart';
import 'detailpage_kwu.dart';

class Kwu extends StatelessWidget {
  const Kwu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kantin UKM KWU',
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
                    'https://shorturl.at/ZW8QS',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kantin UKM KWU',
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
                name: 'Lalapan Ayam',
                price: 'Rp. 13.000',
                rating: '4.5',
                imageUrl:
                    'https://cdn-1.timesmedia.co.id/images/2023/07/03/Lalapan-2.jpg',
                addOns: [],
              ),
              MenuItem(
                name: 'Cireng',
                price: 'Rp. 5.000',
                rating: '4.7',
                imageUrl: 'https://shorturl.at/aPpen',
                addOns: [],
              ),
            ],
          ),
          MenuCategory(
            title: 'Minuman',
            items: [
              MenuItem(
                name: 'Aneka Es',
                price: 'Rp. 4.000',
                rating: '4.5',
                imageUrl:
                    'https://asset-2.tstatic.net/jambi/foto/bank/images/segernya-aneka-es-buatan-umkm-di-jambi-ini-sehari-bisa-laku-400-cup.jpg',
                addOns: ['Es Milo', 'Es Teh', 'Pop Ice'],
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
                      builder: (context) => DetailPage(menuItem2: item),
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
