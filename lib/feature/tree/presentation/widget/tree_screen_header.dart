import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class TreeScreenHeader extends StatelessWidget {
  const TreeScreenHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (Get.key.currentState?.canPop() ?? false) {
              Get.back();
            }
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: AppColors.black,
          ),
        ),
        AppText(
          data: title,
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'hanken',
        ),
      ],
    );
  }
}
