import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/nofication/presentation/model/notification_item.dart';
import 'package:spendlock/feature/nofication/presentation/widget/notification_section.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppbar(text: 'Notifications', centerTitle: false),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        itemCount: NotificationData.sections.length,
        separatorBuilder: (_, __) => SizedBox(height: 24.h),
        itemBuilder: (context, index) {
          return NotificationSection(section: NotificationData.sections[index]);
        },
      ),
    );
  }
}
