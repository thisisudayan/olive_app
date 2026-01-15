// Oliver Badge
// Check badge color by badgeText with switch case
// if badgeText is not in the switch case, return gray
// if badgeText is null return null
import 'package:flutter/material.dart';

class OliverBadge extends StatelessWidget {
  final String? badgeText;

  const OliverBadge({
    super.key,
    required this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    if (badgeText == null) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getBadgeColor(badgeText!).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getBadgeColor(badgeText!).withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        badgeText!.toUpperCase(),
        style: TextStyle(
          color: _getBadgeColor(badgeText!),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getBadgeColor(String badgeText) {
    switch (badgeText.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.grey;
      case 'pending':
        return Colors.orange;
      case 'invited':
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }
}