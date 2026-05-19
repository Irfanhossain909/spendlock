import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/feature/tree/presentation/model/growth_stage.dart';
import 'package:spendlock/feature/tree/presentation/model/user_tree_stats.dart';

class TreeController extends GetxController {
  final userStats = const UserTreeStats(
    currentStreakDays: 12,
    weeklyGoalProgress: 5,
    weeklyGoalTotal: 7,
    monthlySaved: 127,
    totalSaved: 543,
  ).obs;

  final growthStages = <GrowthStage>[
    const GrowthStage(
      id: 'seed',
      title: 'Seed',
      icon: AppAssets.seed,
      isActive: false,
    ),
    const GrowthStage(
      id: 'sprout',
      title: 'Sprout',
      icon: AppAssets.sprout,
      isActive: false,
    ),
    const GrowthStage(
      id: 'sapling',
      title: 'Sapling',
      icon: AppAssets.sapling,
      isActive: false,
    ),
    const GrowthStage(
      id: 'young_tree',
      title: 'Young Tree',
      icon: AppAssets.youngTree,
      isActive: true,
    ),
  ].obs;
}
