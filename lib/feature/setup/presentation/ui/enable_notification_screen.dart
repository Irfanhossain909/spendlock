import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_assets.dart';
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
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              SvgPicture.asset(
                AppAssets.alartNotification,
                width: 188.w,
                height: 188.w,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: 240.w,
                child: AppText(
                  data: 'Stay on track with reminders',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 24.h),
              _buildSelectionCard(
                title: 'Lock-time warnings',
                subtitle: 'Know before your spending window closes.',
                icon: Icons.notifications_none,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 12.h),
              _buildSelectionCard(
                title: 'Streak celebrations',
                subtitle: 'Get notified when you hit new saving milestones.',
                icon: Icons.stars_outlined,
                color: Colors.orangeAccent,
              ),
              SizedBox(height: 12.h),
              _buildSelectionCard(
                title: 'Weekly recaps',
                subtitle: 'A smart summary of your financial progress.',
                icon: Icons.insights_outlined,
                color: AppColors.blueAccent,
              ),
              SizedBox(height: 12.h),

              // SelectionCard(
              //   title: 'Lock-time warnings',
              //   subtitle: 'Know before your spending window closes.',
              //   icon: Icons.access_time,
              //   isSelected: true,
              //   onTap: () {},
              // ),
              // SizedBox(height: 12.h),
              // SelectionCard(
              //   title: 'Streak celebrations',
              //   subtitle: 'Get notified when you hit new saving milestones.',
              //   icon: Icons.star_outline,
              //   isSelected: true,
              //   onTap: () {},
              // ),
              // SizedBox(height: 12.h),
              // SelectionCard(
              //   title: 'Weekly recaps',
              //   subtitle: 'A smart summary of your financial progress.',
              //   icon: Icons.insights_outlined,
              //   isSelected: true,
              //   onTap: () {},
              // ),
              const Spacer(),
              AppButton(
                title: 'Enable Notifications',
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
      ),
    );
  }

  _buildSelectionCard({
    String? title,
    String? subtitle,
    IconData? icon,
    Color? color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color?.withValues(alpha: 0.1) ?? AppColors.primarySurface,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, size: 20.sp, color: color ?? AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: title ?? 'N/A',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'hanken',
                  maxLines: 2,
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  AppText(
                    data: subtitle,
                    fontSize: 13.sp,
                    color: AppColors.gray,
                    fontFamily: 'inter',
                    maxLines: 2,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
