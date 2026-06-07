import 'package:flutter/material.dart';

enum RulesFilter { all, active, paused }

enum RuleBadgeType { time, limit }

class RuleItem {
  RuleItem({
    required this.id,
    required this.title,
    required this.time,
    required this.socialName,
    required this.duration,
    required this.icon,
    required this.iconBgColor,
    required this.badgeType,
    required this.socialIcons,
    this.isActive = true,
    this.statusLabel = 'Active',
  });

  final String id;
  final String title;
  final String time;
  final String socialName;
  final String duration;
  final String statusLabel;
  final IconData icon;
  final Color iconBgColor;
  final RuleBadgeType badgeType;
  final List<IconData> socialIcons;
  bool isActive;
}
