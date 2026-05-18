import 'package:flutter/material.dart';

class SelectableAppItem {
  const SelectableAppItem({
    required this.id,
    required this.name,
    required this.category,
    required this.icon,
    this.iconColor,
    this.iconBgColor,
  });

  final String id;
  final String name;
  final String category;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBgColor;
}

class SelectableAppsCatalog {
  SelectableAppsCatalog._();

  static const List<SelectableAppItem> defaults = [
    SelectableAppItem(
      id: 'facebook',
      name: 'Facebook',
      category: 'Social',
      icon: Icons.facebook,
      iconColor: Color(0xFF1877F2),
      iconBgColor: Color(0xFFE7F1FF),
    ),
    SelectableAppItem(
      id: 'youtube',
      name: 'Youtube',
      category: 'Entertainment',
      icon: Icons.play_circle_outline,
      iconColor: Color(0xFFFF0000),
      iconBgColor: Color(0xFFFFE8E8),
    ),
    SelectableAppItem(
      id: 'telegram',
      name: 'Telegram',
      category: 'Social',
      icon: Icons.send_outlined,
      iconColor: Color(0xFF0088CC),
      iconBgColor: Color(0xFFE8F4FF),
    ),
    SelectableAppItem(
      id: 'whatsapp',
      name: 'Whatsapp',
      category: 'Social',
      icon: Icons.chat_outlined,
      iconColor: Color(0xFF25D366),
      iconBgColor: Color(0xFFE6FFFA),
    ),
    SelectableAppItem(
      id: 'tiktok',
      name: 'Tiktok',
      category: 'Entertainment',
      icon: Icons.music_note_outlined,
      iconColor: Color(0xFF000000),
      iconBgColor: Color(0xFFF3F4F6),
    ),
    SelectableAppItem(
      id: 'messenger',
      name: 'Messenger',
      category: 'Social',
      icon: Icons.forum_outlined,
      iconColor: Color(0xFF006AFF),
      iconBgColor: Color(0xFFE7F1FF),
    ),
  ];
}
