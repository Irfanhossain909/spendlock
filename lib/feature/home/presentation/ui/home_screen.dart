import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/home/presentation/controller/home_controller.dart';
import 'package:spendlock/feature/home/presentation/widget/rule_tile.dart';
import 'package:spendlock/feature/home/presentation/widget/savings_card.dart';
import 'package:spendlock/feature/home/presentation/widget/streak_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22.r,
                          backgroundColor: AppColors.primarySurface,
                          child: Icon(Icons.person, color: AppColors.primary, size: 24.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: 'Good Morning!',
                                fontSize: 14.sp,
                                color: AppColors.darkGray,
                                fontFamily: 'hanken',
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.coinBg,
                            border: Border.all(color: AppColors.coinGold.withValues(alpha: 0.2)),
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.monetization_on, color: AppColors.coinGold, size: 18.sp),
                              SizedBox(width: 4.w),
                              AppText(
                                data: '${controller.coins.value} COINS',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3A0B00),
                                fontFamily: 'hanken',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SavingsCard(amount: controller.totalSavings.value),
                    SizedBox(height: 16.h),
                    StreakCard(
                      streakDays: controller.streakDays.value,
                      weeklyProgress: controller.weeklyProgress.value,
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
                        AppText(
                          data: 'See all',
                          fontSize: 11.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter',
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    ...controller.activeRules.map(
                      (rule) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: RuleTile(rule: rule),
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
