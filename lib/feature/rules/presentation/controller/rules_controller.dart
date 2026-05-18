import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_item.dart';

class RulesController extends GetxController {
  final selectedFilter = RulesFilter.all.obs;

  final rules = <RuleItem>[
    RuleItem(
      id: '1',
      title: 'No food delivery after 9 am',
      time: '9 PM - 6 PM',
      socialName: 'Lock 3 apps',
      duration: '02:14h left',
      icon: Icons.lunch_dining_outlined,
      iconBgColor: const Color(0xFFFFE8EC),
      badgeType: RuleBadgeType.time,
      socialIcons: const [Icons.facebook, Icons.chat, Icons.camera_alt_outlined],
      isActive: true,
    ),
    RuleItem(
      id: '2',
      title: 'No food delivery after 9 am',
      time: '9 PM - 6 PM',
      socialName: 'Lock 3 apps',
      duration: '02:14h left',
      icon: Icons.shopping_cart_outlined,
      iconBgColor: const Color(0xFFEDE9FF),
      badgeType: RuleBadgeType.time,
      socialIcons: const [Icons.facebook, Icons.chat, Icons.camera_alt_outlined],
      isActive: true,
    ),
    RuleItem(
      id: '3',
      title: 'No food delivery after 9 am',
      time: '9 PM - 6 PM',
      socialName: 'Lock 3 apps',
      duration: '02:14h left',
      icon: Icons.account_balance_wallet_outlined,
      iconBgColor: const Color(0xFFE8F4FF),
      badgeType: RuleBadgeType.limit,
      socialIcons: const [Icons.facebook, Icons.chat, Icons.camera_alt_outlined],
      isActive: false,
    ),
    RuleItem(
      id: '4',
      title: 'No food delivery after 9 am',
      time: '9 PM - 6 PM',
      socialName: 'Lock 3 apps',
      duration: '02:14h left',
      icon: Icons.coffee_outlined,
      iconBgColor: const Color(0xFFFFF0E0),
      badgeType: RuleBadgeType.time,
      socialIcons: const [Icons.facebook, Icons.chat, Icons.camera_alt_outlined],
      isActive: true,
    ),
  ].obs;

  List<RuleItem> get filteredRules {
    switch (selectedFilter.value) {
      case RulesFilter.all:
        return rules;
      case RulesFilter.active:
        return rules.where((rule) => rule.isActive).toList();
      case RulesFilter.paused:
        return rules.where((rule) => !rule.isActive).toList();
    }
  }

  int get activeCount => rules.where((rule) => rule.isActive).length;

  void changeFilter(RulesFilter filter) {
    selectedFilter.value = filter;
  }

  void toggleRule(String id, bool isActive) {
    final index = rules.indexWhere((rule) => rule.id == id);
    if (index == -1) return;
    rules[index].isActive = isActive;
    rules.refresh();
  }
}
