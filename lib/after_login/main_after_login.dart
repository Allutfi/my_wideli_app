import 'package:flutter/material.dart';
import 'package:wideli/after_login/akun_page_after_login.dart';
import 'package:wideli/after_login/home_page.dart';
import 'package:wideli/after_login/pesanan_page.dart';
import 'package:wideli/after_login/tas_page.dart';

class MainAfterLogin extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MainAfterLogin({super.key, required this.userData});

  @override
  State<MainAfterLogin> createState() => _MainAfterLoginState();
}

class _MainAfterLoginState extends State<MainAfterLogin> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const HomePage(isLoggedIn: true),
      const CartPage(),
      const OrdersScreen(),
      AkunPageAfterLogin(
        userData: widget.userData,
        nama: widget.userData['nama_lengkap'] ?? '',
        username: widget.userData['username'] ?? '',
        kelas: widget.userData['kelas'] ?? '',
        prodi: widget.userData['kelas']?.split('-').first ?? '',
        onLogout: () {
          Navigator.pop(context);
        },
      ),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Tas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Pesanan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}
