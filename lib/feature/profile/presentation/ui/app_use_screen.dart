import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/profile/presentation/model/app_usage_item.dart';
import 'package:spendlock/feature/profile/presentation/widget/app_usage_section.dart';

class AppUseScreen extends StatelessWidget {
  const AppUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppbar(text: 'App Usages', centerTitle: false),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        children: [
          AppUsageSection(
            title: 'Lock Time',
            trailing: 'This Week',
            items: AppUsageData.lockTimeThisWeek,
          ),
          SizedBox(height: 24.h),
          AppUsageSection(
            title: 'Money Saved',
            items: AppUsageData.moneySaved,
          ),
        ],
      ),
    );
  }
}
