import '../menu/base_menu_item.dart';

class CartItem {
  final BaseMenuItem menuItem; // Gunakan tipe base class
  final int quantity;
  final List<String> selectedAddOns;
  final String note;
  final String kantin;

  CartItem({
    required this.menuItem,
    required this.quantity,
    required this.selectedAddOns,
    required this.note,
    required this.kantin,
  });
}
