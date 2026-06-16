import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/tree/presentation/controller/tree_controller.dart';
import 'package:spendlock/feature/tree/presentation/widget/growth_journey_section.dart';
import 'package:spendlock/feature/tree/presentation/widget/tree_hero.dart';
import 'package:spendlock/feature/tree/presentation/widget/tree_screen_header.dart';
import 'package:spendlock/feature/tree/presentation/widget/tree_stats_card.dart';

class TreeScreen extends GetView<TreeController> {
  const TreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                const TreeScreenHeader(title: 'Rules'),
                SizedBox(height: 8.h),
                TreeHero(totalCoins: controller.totalCoins.value),
                SizedBox(height: 16.h),
                TreeStatsCard(stats: controller.overview.value),
                SizedBox(height: 24.h),
                GrowthJourneySection(
                  stages: controller.growthStages,
                  activeIndex: getGrowthStageIndex(controller.totalCoins.value),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int getGrowthStageIndex(int? value) {
  if (value == null || value <= 0) {
    return 0;
  }

  if (value >= 1 && value <= 7) {
    return 0;
  } else if (value >= 8 && value <= 16) {
    return 1;
  } else if (value >= 17 && value <= 32) {
    return 2;
  } else {
    return 3;
  }
}
