import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_input/app_input_field.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/component/spendlock_branding.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/auth/presentation/controller/reset_password_controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.authBackground),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 24.h,
              ),
              child: Column(
                children: [
                  const SpendLockBranding(logoSize: 66, centered: true),
                  SizedBox(height: 16.h),
                  AppText(
                    data: 'Reset Password',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    data: 'Set your new password',
                    fontSize: 14.sp,
                    color: AppColors.gray,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  AuthFormCard(
                    child: Column(
                      children: [
                        AppInputField(
                          label: 'New Password',
                          hint: 'Enter new password',
                          controller: controller.newPasswordController,
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        SizedBox(height: 16.h),
                        AppInputField(
                          label: 'Confirm Password',
                          hint: 'Confirm password',
                          controller: controller.confirmPasswordController,
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        SizedBox(height: 24.h),
                        Obx(
                          () => AppButton(
                            title: 'Save',
                            isLoading: controller.isLoading.value,
                            onTap: controller.save,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
