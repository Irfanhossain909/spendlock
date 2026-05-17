import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';

class SetChallengeScreen extends GetView<SetupController> {
  const SetChallengeScreen({super.key});

  static const _challenges = [
    (Icons.nightlight_round, 'Late-night food delivery'),
    (Icons.shopping_bag_outlined, 'Online shopping sprees'),
    (Icons.coffee_outlined, 'Coffee & cafes'),
    (Icons.movie_outlined, 'Entertainment'),
    (Icons.more_horiz, 'Something else'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SetupProgressHeader(currentStep: 2, totalSteps: 5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            AppText(
              data: "What's your biggest challenge?",
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              maxLines: 2,
            ),
            SizedBox(height: 8.h),
            AppText(
              data: 'Select all that apply. This helps us customize your spending locks.',
              fontSize: 14.sp,
              color: AppColors.gray,
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Obx(
                () {
                  final selected = Set<int>.from(controller.selectedChallenges);
                  return ListView.separated(
                    itemCount: _challenges.length,
                    separatorBuilder: (_, index) => SizedBox(height: 16.h),
                    itemBuilder: (_, i) {
                      final c = _challenges[i];
                      return SelectionCard(
                        title: c.$2,
                        icon: c.$1,
                        isSelected: selected.contains(i),
                        onTap: () => controller.toggleChallenge(i),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: AppButton(
                title: 'Continue',
                showArrow: true,
                onTap: () => Get.toNamed(AppRoutes.instance.enableNotificationScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
