import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/tree/presentation/model/growth_stage.dart';

class GrowthJourneyCard extends StatelessWidget {
  const GrowthJourneyCard({super.key, required this.stage, required this.isActive});

  final GrowthStage stage;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Container(
            width: 88.w,
            margin: EdgeInsets.only(right: 12.w),
            padding: EdgeInsets.fromLTRB(8.w, 16.h, 8.w, 12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isActive ? AppColors.primary : AppColors.stroke,
                width: isActive ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(stage.icon, width: 36.w, height: 36.h),
                SizedBox(height: 8.h),
                AppText(
                  data: stage.title,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray,
                  fontFamily: 'hanken',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        if (isActive)
          Positioned(
            top: 2.h,
            right: 40.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: AppText(
                data: "YOU",
                fontSize: 8.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                fontFamily: 'hanken',
              ),
            ),
          ),
      ],
    );
  }
}
