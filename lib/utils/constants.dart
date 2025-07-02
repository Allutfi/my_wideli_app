class AppConstants {
  // App Info
  static const String appName = 'Wideli App';

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Border Radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  // Menu Items
  static const List<Map<String, String>> menuItems = [
    {
      'title': 'Kantin B. Ika',
      'subtitle': 'Sarapan praktis & lezat',
      'image': 'assets/images/kantin_b_ika.jpg'
    },
    {
      'title': 'Kantin B. Yon',
      'subtitle': 'Cemilan diwaktu santai',
      'image': 'assets/images/kantin_b_yon.jpg'
    },
    {
      'title': 'Kantin UKM KWU',
      'subtitle': 'Jajanan kekinian',
      'image': 'assets/images/kantin_ukm.jpg'
    },
    {
      'title': 'Karya Nusa',
      'subtitle': 'Menunjang kebutuhan kuliah anda',
      'image': 'assets/images/karya_nusa.jpg'
    },
  ];

  // Reward Items
  static const List<Map<String, dynamic>> rewardItems = [
    {
      'title': 'WildaPay',
      'subtitle': 'Rp 0',
      'color': 0xFF2196F3,
      'icon': 'wallet'
    },
    {'title': 'Gold', 'subtitle': 'point', 'color': 0xFFFFD700, 'icon': 'star'},
    {
      'title': 'Vouchers',
      'subtitle': '',
      'color': 0xFFFF9800,
      'icon': 'ticket'
    },
  ];
}
