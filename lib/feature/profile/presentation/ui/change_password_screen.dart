import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_input/app_input_field.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/profile/presentation/controller/change_password_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CustomAppbar(
            text: 'Change Password',
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: AuthFormCard(
              child: Column(
                children: [
                  AppInputField(
                    label: 'Password',
                    hint: 'Enter current password',
                    controller: controller.currentPasswordController,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  SizedBox(height: 16.h),
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
                    hint: 'Confirm new password',
                    controller: controller.confirmPasswordController,
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  SizedBox(height: 20.h),
                  AppButton(
                    title: 'Edit',
                    isLoading: controller.isSaving,
                    onTap: controller.updatePassword,
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
