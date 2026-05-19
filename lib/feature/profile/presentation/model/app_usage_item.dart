import 'package:flutter/material.dart';
import 'package:spendlock/core/const/app_assets.dart';

class AppUsageItem {
  const AppUsageItem({
    required this.name,
    required this.category,
    required this.value,
    this.iconPath,
    this.iconData,
    this.iconBackground,
  });

  final String name;
  final String category;
  final String value;
  final String? iconPath;
  final IconData? iconData;
  final Color? iconBackground;
}

class AppUsageData {
  AppUsageData._();

  static const List<AppUsageItem> lockTimeThisWeek = [
    AppUsageItem(
      name: 'Uber Eats',
      category: 'Food Delivery',
      value: '43m',
      iconPath: AppAssets.uber,
    ),
    AppUsageItem(
      name: 'Amazon',
      category: 'Shopping',
      value: '43m',
      iconData: Icons.shopping_bag_outlined,
      iconBackground: Color(0xFFFF9900),
    ),
    AppUsageItem(
      name: 'Ebay',
      category: 'Shopping',
      value: '43m',
      iconData: Icons.storefront_outlined,
      iconBackground: Color(0xFFE53238),
    ),
  ];

  static const List<AppUsageItem> moneySaved = [
    AppUsageItem(
      name: 'Grubhub',
      category: 'Food Delivery',
      value: '\$123',
      iconData: Icons.restaurant_outlined,
      iconBackground: Color(0xFFF63440),
    ),
    AppUsageItem(
      name: 'Walmart',
      category: 'Shopping',
      value: '\$32',
      iconData: Icons.local_grocery_store_outlined,
      iconBackground: Color(0xFF0071CE),
    ),
    AppUsageItem(
      name: 'Netflix',
      category: 'Entertainment',
      value: '\$78',
      iconData: Icons.movie_outlined,
      iconBackground: Color(0xFFE50914),
    ),
    AppUsageItem(
      name: 'Doordash',
      category: 'Food Delivery',
      value: '\$40',
      iconData: Icons.delivery_dining_outlined,
      iconBackground: Color(0xFFFF3008),
    ),
  ];
}
