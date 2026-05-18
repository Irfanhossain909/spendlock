import 'package:flutter/material.dart';

class RuleCategory {
  const RuleCategory({
    required this.id,
    required this.label,
    required this.icon,
    this.iconColor,
    this.iconBgColor,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBgColor;
}

class RuleCategories {
  RuleCategories._();

  static const List<RuleCategory> all = [
    RuleCategory(
      id: 'shopping',
      label: 'Shopping',
      icon: Icons.shopping_bag_outlined,
      iconColor: Color(0xFF0E8279),
      iconBgColor: Color(0xFFE0F5F2),
    ),
    RuleCategory(
      id: 'food',
      label: 'Food',
      icon: Icons.restaurant_outlined,
      iconColor: Color(0xFFD97706),
      iconBgColor: Color(0xFFFFF4D6),
    ),
    RuleCategory(
      id: 'travel',
      label: 'Travel',
      icon: Icons.flight_outlined,
      iconColor: Color(0xFF7265FF),
      iconBgColor: Color(0xFFEDE9FF),
    ),
    RuleCategory(
      id: 'social',
      label: 'Social',
      icon: Icons.people_outline,
      iconColor: Color(0xFF2563EB),
      iconBgColor: Color(0xFFE8F4FF),
    ),
    RuleCategory(
      id: 'games',
      label: 'Games',
      icon: Icons.sports_esports_outlined,
      iconColor: Color(0xFFDB2777),
      iconBgColor: Color(0xFFFFE8EC),
    ),
    RuleCategory(
      id: 'apps',
      label: 'Apps',
      icon: Icons.apps_outlined,
      iconColor: Color(0xFF059669),
      iconBgColor: Color(0xFFD1FAE5),
    ),
  ];
}
