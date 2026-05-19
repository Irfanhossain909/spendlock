import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/nofication/presentation/model/notification_item.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: item.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: item.showBorder ? Border.all(color: AppColors.stroke) : null,
        boxShadow: item.cardBackground == AppColors.white
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NotificationIcon(item: item),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppText(
                        data: item.title,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'hanken',
                        maxLines: 2,
                      ),
                    ),
                    if (item.timestamp != null) ...[
                      SizedBox(width: 8.w),
                      AppText(
                        data: item.timestamp!,
                        fontSize: 12.sp,
                        color: AppColors.lightGray,
                        fontFamily: 'inter',
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                AppText(
                  data: item.body,
                  fontSize: 13.sp,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: item.iconBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(child: _buildIcon()),
    );
  }

  Widget _buildIcon() {
    switch (item.iconType) {
      case NotificationIconType.svg:
        return SvgPicture.asset(
          item.iconPath!,
          width: 24.w,
          height: 24.w,
        );
      case NotificationIconType.image:
        return AppImageCircular(
          path: item.iconPath,
          width: 32.w,
          height: 32.w,
          borderRadius: 8.r,
          fit: BoxFit.cover,
        );
      case NotificationIconType.icon:
        return Icon(
          item.iconData ?? Icons.notifications_outlined,
          size: 22.sp,
          color: item.iconColor,
        );
    }
  }
}
