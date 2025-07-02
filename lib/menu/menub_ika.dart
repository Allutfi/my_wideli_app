import 'package:wideli/after_login/tas_page.dart';
import 'package:flutter/material.dart';
import 'base_menu_item.dart';
import 'detailpage_bika.dart';

class Bika extends StatelessWidget {
  const Bika({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kantin B. Ika',
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
                    'https://shorturl.at/VmzqS',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kantin B. Ika',
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
                name: 'Pecel Andalan',
                price: 'Rp. 8.000',
                rating: '4.5',
                imageUrl:
                    'https://cdn.rri.co.id/berita/Surabaya/o/1727658322975-IMG_9009/16rmgzrjrup58wn.jpeg',
                addOns: ['Telur Ceplok', 'Telur Dadar'],
              ),
              MenuItem(
                name: 'Rawon',
                price: 'Rp. 8.000',
                rating: '4.7',
                imageUrl:
                    'https://www.dapurumami.com/backup/dapurumami-test/recipe/Resep%20Rawon-YhEGKU1669005458-400.webp',
                addOns: ['Pedas', 'Sedang'],
              ),
              MenuItem(
                name: 'Soto Ayam',
                price: 'Rp. 8.000',
                rating: '4.6',
                imageUrl:
                    'https://www.dapurumami.com/backup/dapurumami-test/recipe/Soto%20Ayam%20Madiun%20ala%20Masako%C2%AE-zgmNvz1655276924-400.webp',
                addOns: ['Pedas', 'Sedang'],
              ),
              MenuItem(
                name: 'Aneka Mie',
                price: 'Rp. 8.000',
                rating: '4.8',
                imageUrl:
                    'https://lh6.googleusercontent.com/H2-Cl_qy_7tew052O2SMOWIF2aXsB-Ut_HNFwMnTj9OvB7BKVQg-MdT3MAxw4Elp2E3bvipkMvtrjMPN36ls5F-OMz5p1zGnJPnp4L1fH82A8b811xkdU4cuBfsW01rKsjXUpyf8GPkvdvtlW3JxPBXwA5IPsKnKxmpy8VvByA7BspANl0ZFzDfQyeO8_g',
                addOns: ['Nasi', 'Telur Ceplok', 'Telur Dadar'],
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
                addOns: [],
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
                      builder: (context) => DetailPage(menuItem: item),
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
