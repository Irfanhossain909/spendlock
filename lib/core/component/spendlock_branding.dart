import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';

class SpendLockBranding extends StatelessWidget {
  const SpendLockBranding({
    super.key,
    this.logoSize = 48,
    this.showTagline = false,
    this.centered = false,
  });

  final double logoSize;
  final bool showTagline;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppAssets.logo, width: logoSize.w, height: logoSize.w),
        if (showTagline) ...[
          SizedBox(height: 8.h),
          AppText(
            data: 'SpendLock',
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            textAlign: centered ? TextAlign.center : null,
          ),
          SizedBox(height: 4.h),
          AppText(
            data: 'Spend less, Grow more.',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.gray,
            textAlign: centered ? TextAlign.center : null,
          ),
        ],
      ],
    );
    return centered ? Center(child: content) : content;
  }
}
