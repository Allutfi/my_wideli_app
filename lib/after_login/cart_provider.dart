import 'package:flutter/material.dart';
import 'cart_model.dart';

class CartProvider with ChangeNotifier {
  // Cart items
  final List<CartItem> _items = [];
  // Order history
  final List<Order> _orders = [];

  List<CartItem> get items => _items;
  List<Order> get orders => _orders;

  void createOrder(List<CartItem> items,
      {required double deliveryFee, required String deliveryOption}) async {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items),
      total: calculateTotal(items),
      deliveryFee: deliveryFee,
      deliveryOption: deliveryOption,
      orderDate: DateTime.now(),
    );
    _orders.add(order);
    notifyListeners();
  }

  // Add item to cart
  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  // Clear all items from cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void cancelOrderById(String id) {
    final order = _orders.firstWhere((order) => order.id == id);
    order.status = 'Dibatalkan';
    notifyListeners();
  }

  double parsePrice(String priceStr) {
    // Hapus semua karakter non-digit termasuk titik ribuan
    String cleaned = priceStr.replaceAll(RegExp(r'[^\d]'), '');

    // Konversi ke double dan bagi 100 jika aslinya menggunakan titik sebagai desimal
    return double.tryParse(cleaned) ?? 0.0;
  }

  double calculateTotal(List<CartItem> items) {
    return items.fold(0.0, (sum, item) {
      final price = parsePrice(item.menuItem.price);
      return sum + (price * item.quantity);
    });
  }

  String _selectedDeliveryOption = 'standar';
  double get deliveryFee => getDeliveryFee(_selectedDeliveryOption);

  double getDeliveryFee(String option) {
    switch (option) {
      case 'prioritas':
        return 15000.0;
      case 'standar':
        return 10000.0;
      case 'hemat':
        return 5000.0;
      default:
        return 10000.0;
    }
  }

  void setDeliveryOption(String option) {
    _selectedDeliveryOption = option;
    notifyListeners();
  }

  double calculateDeliveryFee() {
    // Logika untuk menghitung ongkos kirim
    // Contoh sederhana:
    return 10000.0; // Nilai default ongkir
  }

  // Update order status
  void updateOrderStatus(String orderId, String newStatus) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      final oldOrder = _orders[orderIndex];
      final updatedOrder = Order(
        id: oldOrder.id,
        items: oldOrder.items,
        total: oldOrder.total,
        deliveryFee: oldOrder.deliveryFee,
        deliveryOption:
            oldOrder.deliveryOption, // Sertakan nilai deliveryOption
        orderDate: oldOrder.orderDate,
        status: newStatus,
      );
      _orders[orderIndex] = updatedOrder;
      notifyListeners();
    }
  }

  // Get total price of items in cart
  double get cartTotal => _items.fold(
      0,
      (sum, item) =>
          sum +
          (int.parse(item.menuItem.price.replaceAll(RegExp(r'[^0-9]'), '')) *
              item.quantity));

  // Format price for display
  String formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  void addItem(CartItem cartItem) {}
}

class Order {
  final String id;
  final List<CartItem> items;
  final DateTime orderDate;
  String status;
  final double total;
  final double deliveryFee;
  final String deliveryOption;

  Order({
    required this.items,
    required this.deliveryFee,
    required this.deliveryOption,
    required this.orderDate,
    this.status = 'Diproses',
    required String id,
    required double total,
  })  : id = orderDate.millisecondsSinceEpoch.toString(),
        total = items.fold(
            0,
            (sum, item) =>
                sum +
                (int.parse(
                        item.menuItem.price.replaceAll(RegExp(r'[^0-9]'), '')) *
                    item.quantity));
}
