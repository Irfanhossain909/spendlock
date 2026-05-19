import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/coin/presentation/model/coin_package_item.dart';

class CoinPackageTile extends StatelessWidget {
  const CoinPackageTile({
    super.key,
    required this.package,
    required this.isSelected,
    required this.onTap,
  });

  final CoinPackageItem package;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.stroke,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.coin,
              width: 28.w,
              height: 28.h,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: package.coinsLabel,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'hanken',
                  ),
                  if (package.subtitle != null) ...[
                    SizedBox(height: 4.h),
                    AppText(
                      data: package.subtitle!,
                      fontSize: 13.sp,
                      color: package.highlightSubtitle
                          ? AppColors.primary
                          : AppColors.gray,
                      fontWeight: package.highlightSubtitle
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontFamily: 'inter',
                    ),
                  ],
                ],
              ),
            ),
            AppText(
              data: package.priceLabel,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              fontFamily: 'hanken',
            ),
          ],
        ),
      ),
    );
  }
}
