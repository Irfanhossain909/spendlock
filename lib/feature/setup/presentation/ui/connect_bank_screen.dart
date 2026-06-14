import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/setup_progress_header.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';

class ConnectBankScreen extends GetView<SetupController> {
  const ConnectBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SetupProgressHeader(currentStep: 5, totalSteps: 5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 48.h),
              SvgPicture.asset(
                AppAssets.bankAccount,
                width: 188.w,
                height: 188.w,
              ),
              SizedBox(height: 32.h),
              AppText(
                data: 'Connect to your bank',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              AppText(
                data:
                    'Securely link an account so we can track spending and enforce your rules in real time',
                fontSize: 14.sp,
                color: AppColors.gray,
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
              const Spacer(),
              GetBuilder<SetupController>(
                builder: (controller) {
                  return AppButton(
                    title: controller.isSubmitting
                        ? 'Finishing...'
                        : 'Finish Setup',
                    onTap: controller.isSubmitting
                        ? null
                        : controller.completeSetup,
                  );
                },
              ),
              SizedBox(height: 12.h),
              // AppButton(
              //   title: 'Skip for now',
              //   outlined: true,
              //   onTap: () => Get.toNamed(AppRoutes.instance.budgetScreen),
              // ),
              // SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
