import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/home/presentation/controller/home_controller.dart';
import 'package:spendlock/feature/home/presentation/widget/savings_card.dart';
import 'package:spendlock/feature/home/presentation/widget/streak_card.dart';
import 'package:spendlock/feature/rules/presentation/widget/rule_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              spacing: 12.w,
              children: [
                AppImageCircular(
                  url: "https://via.placeholder.com/150",
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
                        data: "Sarah Leo",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                      ),
                    ],
                  ),
                ),
              ],
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

                    RuleCard(
                      title: "No food delivery after 9 am",
                      time: "9 PM - 6 PM",
                      socialName: "Lock 3 apps",
                      duration: "02:14h left",
                      icon: Icons.coffee_outlined,
                      iconBgColor: const Color(0xFFFFF0E0),

                      socialIcons: const [
                        Icons.facebook,
                        Icons.chat,
                        Icons.camera_alt_outlined,
                      ],
                      isActive: true,
                      isActiveAction: true,
                      onToggleChanged: (value) {},
                    ),
                    // ...controller.activeRules.map(
                    //   (rule) => Padding(
                    //     padding: EdgeInsets.only(bottom: 16.h),
                    //     child: RuleTile(rule: rule),
                    //   ),
                    // ),
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
