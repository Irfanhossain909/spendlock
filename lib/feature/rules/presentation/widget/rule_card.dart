import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_item.dart';

class RuleCard extends StatelessWidget {
  const RuleCard({
    super.key,
    required this.title,
    required this.time,
    required this.socialName,
    required this.duration,
    this.statusLabel = 'Active',
    required this.icon,
    required this.iconBgColor,
    this.badgeType = RuleBadgeType.time,
    required this.socialIcons,
    required this.isActive,
    required this.onToggleChanged,
    this.onDelete,
    this.isActiveAction = false,
  });

  final String title;
  final String time;
  final String socialName;
  final String duration;
  final String statusLabel;
  final IconData icon;
  final Color iconBgColor;
  final RuleBadgeType badgeType;
  final List<IconData> socialIcons;
  final bool isActive;
  final ValueChanged<bool> onToggleChanged;
  final VoidCallback? onDelete;
  final bool isActiveAction;

  @override
  Widget build(BuildContext context) {
    final badge = _badgeStyle(badgeType);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 22.sp,
                  color: AppColors.black.withValues(alpha: 0.65),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: title,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      fontFamily: 'hanken',
                    ),
                    SizedBox(height: 4.h),
                    AppText(
                      data: time,
                      fontSize: 13.sp,
                      color: AppColors.gray,
                      fontFamily: 'inter',
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        ...socialIcons
                            .take(3)
                            .map(
                              (socialIcon) => Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: _SocialIcon(icon: socialIcon),
                              ),
                            ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: AppText(
                            data: socialName,
                            fontSize: 12.sp,
                            color: AppColors.gray,
                            fontFamily: 'inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: badge.background,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(badge.icon, size: 12.sp, color: badge.foreground),
                    SizedBox(width: 4.w),
                    AppText(
                      data: badge.label,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: badge.foreground,
                      fontFamily: 'inter',
                    ),
                  ],
                ),
              ),
              if (onDelete != null) ...[
                SizedBox(width: 8.w),
                InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.delete_outline,
                      size: 20.sp,
                      color: AppColors.red,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              SizedBox(width: 55.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primaryMint : AppColors.stroke,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: AppText(
                  data: statusLabel,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.primary : AppColors.gray,
                  fontFamily: 'inter',
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: AppText(
                  data: duration,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                ),
              ),
              Spacer(),
              if (!isActiveAction)
                Theme(
                  data: Theme.of(context).copyWith(
                    switchTheme: SwitchThemeData(
                      trackOutlineColor:
                          WidgetStateProperty.resolveWith<Color?>((states) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.primary;
                            }
                            return Colors.transparent; // inactive border none
                          }),
                    ),
                  ),
                  child: Switch(
                    value: isActive,
                    onChanged: onToggleChanged,
                    activeThumbColor: AppColors.white,
                    activeTrackColor: AppColors.primary,
                    inactiveThumbColor: AppColors.white,
                    inactiveTrackColor: AppColors.lightGray.withValues(
                      alpha: 0.5,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  _BadgeStyle _badgeStyle(RuleBadgeType type) {
    switch (type) {
      case RuleBadgeType.time:
        return _BadgeStyle(
          label: 'Time',
          icon: Icons.access_time,
          background: const Color(0xFFEDE9FF),
          foreground: const Color(0xFF7265FF),
        );
      case RuleBadgeType.limit:
        return _BadgeStyle(
          label: 'Limit',
          icon: Icons.account_balance_wallet_outlined,
          background: AppColors.warningYellow,
          foreground: const Color(0xFFB8860B),
        );
    }
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.stroke),
      ),
      child: Icon(icon, size: 11.sp, color: AppColors.gray),
    );
  }
}

class _BadgeStyle {
  const _BadgeStyle({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}
