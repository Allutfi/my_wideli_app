import 'package:flutter/material.dart';
import 'package:wideli/before_login/login_screen.dart';
import '../utils/colors.dart';
import '../after_login/qr_scanner_screen.dart';
import '../after_login/notifikasi_page.dart';
import '../after_login/chat_page.dart';

class CustomAppBar extends StatelessWidget {
  final bool isLoggedIn;

  const CustomAppBar({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        children: [
          // QRIS icon pakai Icon built-in
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                // Navigasi ke QRScannerScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QRScannerScreen()),
                );
              },
              child: const Icon(Icons.qr_code, size: 24),
            ),
          ),

          const SizedBox(width: 12),

          // Search bar
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon:
                      Icon(Icons.search, color: AppColors.textSecondary),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          isLoggedIn
              ? Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NotifikasiPage()),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ChatPage()),
                        );
                      },
                    ),
                  ],
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna background biru
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Radius tombol bulat
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white, // Teks putih
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
