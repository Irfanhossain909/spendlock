import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/feature/home/presentation/controller/home_controller.dart';
import 'package:spendlock/feature/home/presentation/widget/savings_card.dart';
import 'package:spendlock/feature/home/presentation/widget/streak_card.dart';
import 'package:spendlock/feature/navigation/presentation/controller/navigation_controller.dart';
import 'package:spendlock/feature/rules/presentation/widget/rule_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Obx(
              () => Row(
                spacing: 12.w,
                children: [
                  AppImageCircular(
                    url:
                        "${AppApiEndPoint.domain}${controller.displayImageUrl}",
                    width: 40.w,
                    height: 40.w,
                  ),
                  Expanded(
                    child: Column(
                      spacing: 4.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          data: 'Good Morning!',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        AppText(
                          data: controller.userName.value,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'inter',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () =>
                    Get.toNamed(AppRoutes.instance.notificationScreen),
                icon: Icon(Icons.notifications_outlined),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    SavingsCard(amount: controller.totalSavings.value),
                    SizedBox(height: 16.h),
                    StreakCard(
                      streakDays: controller.streakDays.value,
                      weeklyProgress: controller.weeklyProgress.value,
                      coins: controller.coins.value,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          data: 'Active Rules',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray,
                          fontFamily: 'inter',
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.find<NavigationController>().changeIndex(1);
                          },
                          child: AppText(
                            data: 'See all',
                            fontSize: 11.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'inter',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    if (controller.isLoading.value &&
                        controller.activeRules.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    else if (controller.activeRules.isEmpty)
                      AppText(
                        data: 'No active rules',
                        fontSize: 14.sp,
                        color: AppColors.gray,
                        fontFamily: 'inter',
                      )
                    else
                      ...controller.activeRules.map(
                        (rule) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: RuleCard(
                            title: rule.title,
                            time: rule.time,
                            socialName: rule.socialName,
                            duration: rule.duration,
                            statusLabel: rule.statusLabel,
                            icon: rule.icon,
                            iconBgColor: rule.iconBgColor,
                            badgeType: rule.badgeType,
                            socialIcons: rule.socialIcons,
                            isActive: rule.isActive,
                            isActiveAction: true,
                            onToggleChanged: (value) =>
                                controller.toggleRule(rule.id, value),
                          ),
                        ),
                      ),
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
