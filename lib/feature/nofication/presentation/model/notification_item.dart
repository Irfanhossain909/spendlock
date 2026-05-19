import 'package:flutter/material.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';

enum NotificationIconType { svg, image, icon }

class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.body,
    this.timestamp,
    this.iconPath,
    this.iconType = NotificationIconType.icon,
    this.iconData,
    this.iconBackground = AppColors.primarySurface,
    this.iconColor = AppColors.primary,
    this.cardBackground = AppColors.white,
    this.showBorder = false,
  });

  final String title;
  final String body;
  final String? timestamp;
  final String? iconPath;
  final NotificationIconType iconType;
  final IconData? iconData;
  final Color iconBackground;
  final Color iconColor;
  final Color cardBackground;
  final bool showBorder;
}

class NotificationSectionData {
  const NotificationSectionData({
    required this.label,
    required this.items,
  });

  final String label;
  final List<NotificationItem> items;
}

class NotificationData {
  NotificationData._();

  static const List<NotificationSectionData> sections = [
    NotificationSectionData(
      label: 'Today',
      items: [
        NotificationItem(
          title: 'Your Tree just grew! 🌳',
          body: "You've reached Stage 4: Young Tree. Keep it up!",
          timestamp: '2m ago',
          iconPath: AppAssets.youngTree,
          iconType: NotificationIconType.svg,
          iconBackground: AppColors.primaryMint,
          cardBackground: AppColors.primaryMint,
        ),
        NotificationItem(
          title: 'Uber Eats Locked 🔒',
          body: "You've hit your \$100 weekly limit for food delivery.",
          iconPath: AppAssets.uber,
          iconType: NotificationIconType.image,
          iconBackground: AppColors.white,
          showBorder: true,
        ),
      ],
    ),
    NotificationSectionData(
      label: 'Yesterday',
      items: [
        NotificationItem(
          title: 'You earned 5 Coins! 💰',
          body: 'Nice job avoiding that impulse purchase at Starbucks.',
          iconPath: AppAssets.coin,
          iconType: NotificationIconType.svg,
          iconBackground: AppColors.coinBg,
        ),
        NotificationItem(
          title: 'Bank Sync Successful ✅',
          body: 'Your Chase account is up to date.',
          iconData: Icons.account_balance_wallet_outlined,
          iconBackground: Color(0xFFE8F0FF),
          iconColor: AppColors.blueAccent,
        ),
      ],
    ),
  ];
}
