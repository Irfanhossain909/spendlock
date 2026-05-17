import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Rules')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: 'Spending Rules',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 8.h),
            AppText(
              data: 'Create and manage locks to control impulse spending.',
              fontSize: 14.sp,
              color: AppColors.gray,
              maxLines: 2,
            ),
            SizedBox(height: 24.h),
            _RuleTypeCard(
              icon: Icons.access_time,
              title: 'Time-based locks',
              subtitle: 'Restrict spending during specific hours or days.',
              color: AppColors.primarySurface,
            ),
            SizedBox(height: 12.h),
            _RuleTypeCard(
              icon: Icons.attach_money,
              title: 'Spending caps',
              subtitle: 'Set a hard cap on categories or daily spending.',
              color: AppColors.warningYellow,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                onPressed: () {},
                child: const Text('Create New Rule'),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _RuleTypeCard extends StatelessWidget {
  const _RuleTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.r)),
            child: Icon(icon, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(data: title, fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: 'hanken'),
                SizedBox(height: 4.h),
                AppText(data: subtitle, fontSize: 13.sp, color: AppColors.gray, maxLines: 2, fontFamily: 'inter'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
