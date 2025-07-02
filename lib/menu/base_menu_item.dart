abstract class BaseMenuItem {
  final String name;
  final String price;
  final String rating;
  final String imageUrl;
  final List<String> addOns;

  const BaseMenuItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.addOns = const [],
  });
}