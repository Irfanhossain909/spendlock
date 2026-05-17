import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';

class HomeController extends GetxController {
  final userName = ''.obs;
  final streakDays = 12.obs;
  final weeklyProgress = 5.obs;
  final totalSavings = 2450.0.obs;
  final coins = 12.obs;

  final activeRules = <ActiveRule>[
    ActiveRule(
      title: 'No food delivery after 9 PM',
      subtitle: '02:14h left',
      icon: Icons.access_time,
      iconBg: 0xFFE0F5F2,
    ),
    ActiveRule(
      title: 'Weekly Dining',
      subtitle: 'Max \$200',
      icon: Icons.attach_money,
      iconBg: 0xFFFFF4D6,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    userName.value = GetStorageServices.instance.getName();
  }
}

class ActiveRule {
  ActiveRule({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final int iconBg;
}
