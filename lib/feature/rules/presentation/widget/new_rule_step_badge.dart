import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class NewRuleStepBadge extends StatelessWidget {
  const NewRuleStepBadge({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: AppText(
        data: 'Step $currentStep/$totalSteps',
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.gray,
        fontFamily: 'inter',
      ),
    );
  }
}
