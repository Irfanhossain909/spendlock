import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/selection_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/rules/presentation/controller/add_rules_controller.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_type.dart';
import 'package:spendlock/feature/rules/presentation/widget/new_rule_step_badge.dart';

class AddRulsScreen extends GetView<AddRulesController> {
  const AddRulsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(
        text: 'New Rule',
        centerTitle: false,
        action: const [NewRuleStepBadge(currentStep: 1)],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            AppText(
              data: 'Choose Rule Type',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'hanken',
            ),
            SizedBox(height: 8.h),
            AppText(
              data: 'Select how you want to restrict your spending.',
              fontSize: 14.sp,
              color: AppColors.gray,
              fontFamily: 'inter',
              maxLines: 2,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Obx(
                () {
                  final selected = controller.selectedRuleType.value;

                  return ListView(
                    children: [
                      SelectionCard(
                        title: 'Time Based',
                        subtitle:
                            'Restrict spending during specific hours or days to prevent impulse buys.',
                        icon: Icons.schedule_outlined,
                        isSelected: selected == RuleType.timeBased,
                        onTap: () => controller.selectRuleType(RuleType.timeBased),
                      ),
                      SizedBox(height: 16.h),
                      SelectionCard(
                        title: 'Limit Based',
                        subtitle:
                            'Set a hard cap on specific categories or limit daily spending.',
                        icon: Icons.account_balance_wallet_outlined,
                        isSelected: selected == RuleType.limitBased,
                        onTap: () => controller.selectRuleType(RuleType.limitBased),
                      ),
                    ],
                  );
                },
              ),
            ),
            Obx(
              () => AppButton(
                title: 'Continue',
                showArrow: true,
                onTap: controller.canContinue ? controller.continueToSetContent : null,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
