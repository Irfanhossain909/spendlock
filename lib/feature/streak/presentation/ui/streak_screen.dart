import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/streak/presentation/controller/streak_controller.dart';

class StreakScreen extends GetView<StreakController> {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreakController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text('Streak')),
          body: Obx(
            () => Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(height: 32.h),
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: AppColors.coinBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.local_fire_department, size: 64.sp, color: AppColors.coinGold),
                  ),
                  SizedBox(height: 24.h),
                  AppText(
                    data: '${controller.currentStreak.value} Day Streak',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'hanken',
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    data: 'Longest streak: ${controller.longestStreak.value} days',
                    fontSize: 14.sp,
                    color: AppColors.gray,
                  ),
                  SizedBox(height: 40.h),
                  _StatRow(label: 'This week', value: '5/7 days'),
                  SizedBox(height: 12.h),
                  _StatRow(label: 'Coins earned', value: '12'),
                  SizedBox(height: 12.h),
                  _StatRow(label: 'Rules followed', value: '8'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(data: label, fontSize: 14.sp, color: AppColors.gray, fontFamily: 'inter'),
          AppText(data: value, fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: 'hanken'),
        ],
      ),
    );
  }
}
