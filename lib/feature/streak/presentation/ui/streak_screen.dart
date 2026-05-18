import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/streak/presentation/controller/streak_controller.dart';
import 'package:spendlock/feature/streak/presentation/model/milestone_card_state.dart';
import 'package:spendlock/feature/streak/presentation/model/milestone_item.dart';
import 'package:spendlock/feature/streak/presentation/widget/milestone_streak_card.dart';
import 'package:spendlock/feature/streak/presentation/widget/streak_month_calendar.dart';
import 'package:spendlock/feature/streak/presentation/widget/streak_summary_header_card.dart';

class StreakScreen extends GetView<StreakController> {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreakController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Obx(
              () {
                final monthStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: 'Streak',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'hanken',
                    ),
                    SizedBox(height: 20.h),
                    StreakSummaryHeaderCard(
                      currentStreakDays: controller.currentStreak.value,
                      coinBalance: controller.coinBalance.value,
                      onTap: () {},
                    ),
                    SizedBox(height: 28.h),
                    StreakMonthCalendar(
                      month: monthStart,
                      dayRecords: controller.monthDayRecords,
                      onDayTap: controller.onCalendarDayTap,
                    ),
                    SizedBox(height: 28.h),
                    AppText(
                      data: 'Milestone',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'hanken',
                    ),
                    SizedBox(height: 14.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < controller.milestones.length; i++) ...[
                            if (i > 0) SizedBox(width: 12.w),
                            MilestoneStreakCard(
                              item: _milestoneAt(controller, i),
                              onTap: controller.onMilestoneTap,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    AppText(
                      data: 'Longest streak: ${controller.longestStreak.value} days',
                      fontSize: 13.sp,
                      color: AppColors.gray,
                      fontFamily: 'inter',
                    ),
                  ],
                ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

MilestoneItem _milestoneAt(StreakController controller, int index) {
  final m = controller.milestones[index];
  if (m.state == MilestoneCardState.inProgress) {
    return m.copyWith(
      progress: (controller.currentStreak.value / 14).clamp(0.0, 1.0),
    );
  }
  return m;
}
