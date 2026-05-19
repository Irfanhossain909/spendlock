import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/profile/presentation/model/app_usage_item.dart';
import 'package:spendlock/feature/profile/presentation/widget/app_usage_list_tile.dart';

class AppUsageSection extends StatelessWidget {
  const AppUsageSection({
    super.key,
    required this.title,
    required this.items,
    this.trailing,
  });

  final String title;
  final String? trailing;
  final List<AppUsageItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              data: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'hanken',
            ),
            const Spacer(),
            if (trailing != null)
              AppText(
                data: trailing!,
                fontSize: 13.sp,
                color: AppColors.gray,
                fontFamily: 'inter',
              ),
          ],
        ),
        SizedBox(height: 12.h),
        ...items.map((item) => AppUsageListTile(item: item)),
      ],
    );
  }
}
