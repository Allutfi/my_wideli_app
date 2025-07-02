import 'package:flutter/material.dart';
import '../menu/menub_ika.dart';
import '../menu/menub_yon.dart';
import '../menu/menu_kwu.dart';
import '../menu/menu_karyanusa.dart';

class KantinMenuGrid extends StatelessWidget {
  final bool isLoggedIn;

  const KantinMenuGrid({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final kantins = [
      {
        'image': 'assets/images/kantin1.jpg',
        'title': 'Kantin B. Ika',
        'desc': 'Sarapan praktis & lezat'
      },
      {
        'image': 'assets/images/kantin2.jpg',
        'title': 'Kantin B. Yon',
        'desc': 'Cemilan di waktu santai'
      },
      {
        'image': 'assets/images/kantin3.jpg',
        'title': 'Kantin UKM KWU',
        'desc': 'Jajanan kekinian'
      },
      {
        'image': 'assets/images/kantin4.jpeg',
        'title': 'Karya Nusa',
        'desc': 'Kebutuhan Tugas Anda'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: kantins.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final kantin = kantins[index];
          return GestureDetector(
            onTap: isLoggedIn
                ? () {
                    final title = kantin['title'];
                    if (title == 'Kantin B. Ika') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Bika()));
                    } else if (title == 'Kantin B. Yon') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Byon()));
                    } else if (title == 'Kantin UKM KWU') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Kwu()));
                    } else if (title == 'Karya Nusa') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Knusa()));
                    }
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      kantin['image']!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Wideli Canteen',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          kantin['title']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          kantin['desc']!,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
