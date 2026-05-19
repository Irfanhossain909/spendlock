import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/nofication/presentation/model/notification_item.dart';
import 'package:spendlock/feature/nofication/presentation/widget/notification_card.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key, required this.section});

  final NotificationSectionData section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: section.label,
          fontSize: 14.sp,
          color: AppColors.gray,
          fontWeight: FontWeight.w500,
          fontFamily: 'inter',
        ),
        SizedBox(height: 12.h),
        ...section.items.map((item) => NotificationCard(item: item)),
      ],
    );
  }
}
