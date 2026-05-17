import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/home/presentation/controller/home_controller.dart';

class RuleTile extends StatelessWidget {
  const RuleTile({super.key, required this.rule});

  final ActiveRule rule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17.w),
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
            decoration: BoxDecoration(
              color: Color(rule.iconBg),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(rule.icon, size: 20.sp, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: rule.title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'hanken',
                  maxLines: 2,
                ),
                SizedBox(height: 4.h),
                AppText(
                  data: rule.subtitle,
                  fontSize: 14.sp,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.lightGray, size: 24.sp),
        ],
      ),
    );
  }
}
