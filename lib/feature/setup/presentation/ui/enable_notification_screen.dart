import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';

class EnableNotificationScreen extends GetView<SetupController> {
  const EnableNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SetupProgressHeader(currentStep: 3, totalSteps: 5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications_active_outlined, size: 56.sp, color: AppColors.primary),
            ),
            SizedBox(height: 24.h),
            AppText(
              data: 'Stay on track with reminders',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(height: 24.h),
            SelectionCard(
              title: 'Lock-time warnings',
              subtitle: 'Know before your spending window closes.',
              icon: Icons.access_time,
              isSelected: true,
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            SelectionCard(
              title: 'Streak celebrations',
              subtitle: 'Get notified when you hit new saving milestones.',
              icon: Icons.star_outline,
              isSelected: true,
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            SelectionCard(
              title: 'Weekly recaps',
              subtitle: 'A smart summary of your financial progress.',
              icon: Icons.insights_outlined,
              isSelected: true,
              onTap: () {},
            ),
            const Spacer(),
            AppButton(
              title: 'Enable Notifications',
              showArrow: true,
              onTap: () => Get.toNamed(AppRoutes.instance.connectBankScreen),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.instance.connectBankScreen),
              child: AppText(
                data: 'Maybe later',
                fontSize: 14.sp,
                color: AppColors.gray,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
