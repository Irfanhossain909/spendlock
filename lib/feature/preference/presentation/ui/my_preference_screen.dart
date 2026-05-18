import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/preference/presentation/controller/preference_controller.dart';
import 'package:spendlock/feature/preference/presentation/widget/preference_list_tile.dart';

class MyPreferenceScreen extends GetView<PreferenceController> {
  const MyPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferenceController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CustomAppbar(text: 'My Preference', centerTitle: false),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: AuthFormCard(
              horizontalPadding: 0,
              verticalPadding: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PreferenceListTile(
                    icon: Icons.track_changes_outlined,
                    iconColor: Colors.amber.shade700,
                    title: 'My motivation',
                    subtitle: controller.motivationSubtitle,
                    onTap: () async {
                      await Get.toNamed(
                        AppRoutes.instance.preferenceMotivationScreen,
                      );
                      controller.update();
                    },
                  ),
                  PreferenceListTile(
                    icon: Icons.bolt_outlined,
                    iconColor: Colors.pinkAccent,
                    title: 'My triggers',
                    subtitle: controller.triggersSubtitle,
                    onTap: () async {
                      await Get.toNamed(
                        AppRoutes.instance.preferenceTriggersScreen,
                      );
                      controller.update();
                    },
                  ),
                  PreferenceListTile(
                    icon: Icons.account_balance_wallet_outlined,
                    iconColor: AppColors.primary,
                    title: 'Monthly Budget',
                    subtitle: controller.budgetSubtitle,
                    showDivider: false,
                    onTap: () async {
                      await Get.toNamed(
                        AppRoutes.instance.preferenceBudgetScreen,
                      );
                      controller.update();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
