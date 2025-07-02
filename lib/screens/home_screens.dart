import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../after_login/home_page.dart';
import '../after_login/tas_page.dart';
import '../after_login/pesanan_page.dart';
import '../before_login/akun_page_before_login.dart';
import '../after_login/akun_page_after_login.dart';

class HomeScreen extends StatefulWidget {
  final bool userLoggedIn;
  final String username;
  final String nama;
  final String kelas;
  final String prodi;

  const HomeScreen({
    super.key,
    this.userLoggedIn = false,
    this.username = '',
    this.nama = '',
    this.kelas = '',
    this.prodi = '',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomePage(
            isLoggedIn: false,
          ),
          const CartPage(),
          const OrdersScreen(),
          widget.userLoggedIn
              ? AkunPageAfterLogin(
                  username: widget.username,
                  nama: widget.nama,
                  kelas: widget.kelas,
                  prodi: widget.prodi,
                  onLogout: () {},
                  userData: {},
                )
              : AkunPageBeforeLogin(
                  onLoginSuccess: () {
                    // Optionally handle login success here
                  },
                ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
