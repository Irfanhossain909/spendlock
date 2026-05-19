import 'package:flutter/material.dart';
import 'package:spendlock/core/const/app_assets.dart';

class SelectableAppItem {
  const SelectableAppItem({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
  });

  final String id;
  final String name;
  final String category;
  final String icon;
}

class SelectableAppsCatalog {
  SelectableAppsCatalog._();

  static const List<SelectableAppItem> defaults = [
    SelectableAppItem(
      id: 'messanger',
      name: 'Messanger',
      category: 'Social',
      icon: AppAssets.messanger,
    ),
    SelectableAppItem(
      id: 'youtube',
      name: 'Youtube',
      category: 'Entertainment',
      icon: AppAssets.youtube,
    ),

    SelectableAppItem(
      id: 'whatsapp',
      name: 'Whatsapp',
      category: 'Social',
      icon: AppAssets.whatsapp,
    ),
    SelectableAppItem(
      id: 'tiktok',
      name: 'Tiktok',
      category: 'Entertainment',
      icon: AppAssets.tiktok,
    ),
    SelectableAppItem(
      id: 'uber',
      name: 'Uber',
      category: 'Transportation',
      icon: AppAssets.uber,
    ),
  ];
}
