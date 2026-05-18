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
import 'package:spendlock/feature/auth/presentation/controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(gradient: AppColors.authBackground),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SpendLockBranding(logoSize: 48),
                    SizedBox(height: 16.h),
                    AppText(
                      data: 'Welcome back!',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 8.h),
                    AppText(
                      data: 'Continue building your savings streak',
                      fontSize: 14.sp,
                      color: AppColors.gray,
                    ),
                    SizedBox(height: 24.h),
                    AuthFormCard(
                      child: Column(
                        children: [
                          AppInputField(
                            label: 'Email',
                            hint: 'Enter your email',
                            controller: controller.emailController,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16.h),
                          AppInputField(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: controller.passwordController,
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                          ),
                          SizedBox(height: 8.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(
                                AppRoutes.instance.forgotPasswordScreen,
                              ),
                              child: AppText(
                                data: 'Forgot Password',
                                fontSize: 13.sp,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Obx(
                            () => AppButton(
                              title: 'Sign In',
                              isLoading: controller.isLoading.value,
                              showArrow: true,
                              onTap: controller.login,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(color: AppColors.stroke),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                          SocialLoginButton(onTap: controller.googleSignIn),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () =>
                                Get.toNamed(AppRoutes.instance.registerScreen),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.gray,
                                    fontFamily: 'Inter',
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: "Don't have an account? ",
                                    ),
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
