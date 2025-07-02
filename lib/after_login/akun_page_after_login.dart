import 'package:flutter/material.dart';

class AkunPageAfterLogin extends StatelessWidget {
  final VoidCallback onLogout;
  final Map<String, dynamic> userData;
  final String prodi;
  final String kelas;
  final String nama;
  final String username;

  const AkunPageAfterLogin({
    super.key,
    required this.onLogout,
    required this.prodi,
    required this.kelas,
    required this.nama,
    required this.username,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {"title": "Voucher", "icon": Icons.card_giftcard},
      {"title": "Diskusi Produk", "icon": Icons.forum},
      {"title": "Wishlist", "icon": Icons.favorite_border},
      {"title": "Drop Point", "icon": Icons.store_mall_directory},
      {"title": "Bantuan Wideli", "icon": Icons.help_outline},
      {"title": "Lapor Eror Aplikasi", "icon": Icons.bug_report},
      {"title": "Pengaturan", "icon": Icons.settings},
      {"title": "Keluar", "icon": Icons.logout},
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(175, 138, 221, 255),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                nama,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$username@itbwiga.ac.id',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                '$prodi - $kelas',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      print('Pengaturan diklik');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: ListView(
                  children: [
                    ...menuItems.map((item) => Column(
                          children: [
                            ListTile(
                              leading: Icon(item["icon"]),
                              title: Text(item["title"]),
                              onTap: () {
                                if (item["title"] == "Keluar") {
                                  onLogout();
                                }
                              },
                            ),
                            if (item["title"] != "Keluar")
                              const Divider(height: 1),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                width: 180,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    Icon(Icons.info_outline, color: Colors.grey, size: 20),
                    SizedBox(height: 4),
                    Text('Tentang Wideli',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 2),
                    Text(
                      'All Rights Reserved\n2025 WIDELI GROUP',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
