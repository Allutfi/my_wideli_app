import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue, // Warna biru saat aktif
      unselectedItemColor: Colors.grey, // Warna abu saat tidak aktif
      onTap: onItemTapped,
      items: [
        _buildNavItem(Icons.home, 'Home', 0),
        _buildNavItem(Icons.shopping_bag, 'Tas', 1),
        _buildNavItem(Icons.list_alt, 'Pesanan', 2),
        _buildNavItem(Icons.person, 'Akun', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData iconData, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: selectedIndex == index ? 4 : 0, // Naik ke atas saat aktif
          top: selectedIndex == index ? 0 : 4,
        ),
        child: Icon(
          iconData,
          color: selectedIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
      label: label,
    );
  }
}
