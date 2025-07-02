import 'package:flutter/material.dart';

class RewardSection extends StatelessWidget {
  const RewardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildItem(
            icon: Icons.account_balance_wallet,
            title: "WideliPay",
            value: "Rp -",
          ),
          _verticalDivider(),
          _buildItem(
            icon: Icons.star,
            title: "Gold",
            value: "- poin",
            iconColor: Colors.amber[600],
          ),
          _verticalDivider(),
          _buildItem(
            icon: Icons.card_giftcard,
            title: "Vouchers",
            value: "",
            iconColor: Colors.orange[400],
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String title,
    required String value,
    Color? iconColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 28, color: iconColor ?? Colors.blue),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (value.isNotEmpty)
            Text(
              value,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey.shade300,
    );
  }
}
