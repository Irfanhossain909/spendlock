import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_input/app_input_field.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/component/social_login_button.dart';
import 'package:spendlock/core/component/spendlock_branding.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/auth/presentation/controller/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          //     onPressed: Get.back,
          //   ),
          // ),
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.authBackground,
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SpendLockBranding(logoSize: 48),
                      SizedBox(height: 16.h),
                      AppText(
                        data: 'Sign Up',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () =>
                            Get.offNamed(AppRoutes.instance.loginScreen),
                        child: AppText(
                          data: 'Already have an account? Sign In',
                          fontSize: 14.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      AuthFormCard(
                        child: Column(
                          children: [
                            AppInputField(
                              label: 'Name',
                              hint: 'Enter your full name',
                              controller: controller.nameController,
                              prefixIcon: Icons.person_3_rounded,
                            ),
                            SizedBox(height: 16.h),
                            AppInputField(
                              label: 'Email',
                              hint: 'Enter your email',
                              controller: controller.emailController,
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 16.h),
                            AppInputField(
                              label: 'Password',
                              hint: 'Enter your password',
                              controller: controller.passwordController,
                              prefixIcon: Icons.lock,
                              isPassword: true,
                            ),
                            SizedBox(height: 20.h),
                            Obx(
                              () => AppButton(
                                title: 'Sign Up',
                                isLoading: controller.isLoading.value,
                                onTap: controller.register,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(color: AppColors.stroke),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                  ),
                                  child: AppText(
                                    data: 'or',
                                    fontSize: 12.sp,
                                    color: AppColors.gray,
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(color: AppColors.stroke),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            SocialLoginButton(onTap: () {}),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
