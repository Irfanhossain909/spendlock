import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.stroke),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.g_mobiledata, size: 28.sp, color: AppColors.black),
            SizedBox(width: 8.w),
            AppText(
              data: 'Sign in with Google',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'inter',
            ),
          ],
        ),
      ),
    );
  }
}
