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
    return GetBuilder<TreeController>(
      builder: (controller) {
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
                    const TreeHero(),
                    SizedBox(height: 16.h),
                    TreeStatsCard(stats: controller.userStats.value),
                    SizedBox(height: 24.h),
                    GrowthJourneySection(stages: controller.growthStages),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
