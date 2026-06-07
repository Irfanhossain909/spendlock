import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/rules/presentation/controller/set_rules_content_controller.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_category.dart';
import 'package:spendlock/feature/rules/presentation/widget/active_days_selector.dart';
import 'package:spendlock/feature/rules/presentation/widget/category_selector.dart';
import 'package:spendlock/feature/rules/presentation/widget/new_rule_step_badge.dart';
import 'package:spendlock/feature/rules/presentation/widget/rule_name_field.dart';
import 'package:spendlock/feature/rules/presentation/widget/spending_limit_card.dart';
import 'package:spendlock/feature/rules/presentation/widget/time_range_picker_row.dart';

class SetRulsContentScreen extends StatefulWidget {
  const SetRulsContentScreen({super.key});

  @override
  State<SetRulsContentScreen> createState() => _SetRulsContentScreenState();
}

class _SetRulsContentScreenState extends State<SetRulsContentScreen> {
  late final SetRulesContentController controller;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<SetRulesContentController>();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppbar(
        text: 'New Rule',
        centerTitle: false,
        action: [NewRuleStepBadge(currentStep: 2)],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      CategorySelector(
                        categories: RuleCategories.all,
                        selectedIds: controller.selectedCategoryIds.toSet(),
                        onCategoryToggled: controller.toggleCategory,
                      ),
                      SizedBox(height: 24.h),
                      RuleNameField(
                        controller: _nameController,
                        onChanged: controller.updateRuleName,
                      ),
                      SizedBox(height: 24.h),
                      if (controller.isTimeBased) ...[
                        TimeRangePickerRow(
                          from: controller.timeFrom.value,
                          to: controller.timeTo.value,
                          timezoneLabel: controller.timezoneLabel.value,
                          onFromChanged: controller.updateTimeFrom,
                          onToChanged: controller.updateTimeTo,
                        ),
                        SizedBox(height: 24.h),
                        ActiveDaysSelector(
                          selectedIndices: controller.activeDayIndices.toSet(),
                          onDayToggled: controller.toggleActiveDay,
                        ),
                      ] else ...[
                        SpendingLimitCard(
                          initialAmount: controller.spendingLimit.value.amount,
                          initialFrequency: controller.spendingLimit.value.frequency,
                          onChanged: controller.updateSpendingLimit,
                        ),
                      ],
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => AppButton(
                title: 'Continue',
                
                onTap: controller.canContinue ? controller.onContinue : null,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
