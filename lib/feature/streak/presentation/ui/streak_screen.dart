import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/streak/presentation/controller/streak_controller.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_month_day_record.dart';
import 'package:spendlock/feature/streak/presentation/widget/streak_month_calendar.dart';
import 'package:spendlock/feature/streak/presentation/widget/streak_static_reward_section.dart';
import 'package:spendlock/feature/streak/presentation/widget/streak_summary_header_card.dart';

class StreakScreen extends GetView<StreakController> {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          final monthRecords = List<StreakMonthDayRecord>.from(
            controller.monthDayRecords,
          );
          final monthStart = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            1,
          );

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
                if (controller.isLoading.value && monthRecords.isEmpty)
                  SizedBox(
                    height: 220.h,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else
                  StreakMonthCalendar(
                    key: ValueKey(monthRecords.length),
                    month: monthStart,
                    dayRecords: monthRecords,
                    onDayTap: controller.onCalendarDayTap,
                  ),
                SizedBox(height: 28.h),
                const StreakStaticRewardSection(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
