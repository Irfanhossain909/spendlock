import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/const/app_color.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppSnackBar {
  static void _show({
    required String message,
    required Color bgColor,
    required Color textColor,
    String title = '',
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (title.isNotEmpty) SizedBox(height: 4.h),
            Text(message, style: TextStyle(color: textColor, fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }

  static void error(String message) =>
      _show(title: 'Error', message: message, bgColor: AppColors.red, textColor: AppColors.white);

  static void success(String message) => _show(
        title: 'Success',
        message: message,
        bgColor: AppColors.primary,
        textColor: AppColors.white,
      );

  static void message(String message) =>
      _show(message: message, bgColor: AppColors.primaryMint, textColor: AppColors.black);
}
