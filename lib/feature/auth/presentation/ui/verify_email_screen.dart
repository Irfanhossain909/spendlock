import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/component/spendlock_branding.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/auth/presentation/controller/verify_email_controller.dart';

class VerifyEmailScreen extends GetView<VerifyEmailController> {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.authBackground),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                children: [
                  const SpendLockBranding(logoSize: 66, centered: true),
                  SizedBox(height: 16.h),
                  AppText(
                    data: 'Verify OTP',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    data: 'Enter the code sent to your email',
                    fontSize: 14.sp,
                    color: AppColors.gray,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  AuthFormCard(
                    child: Column(
                      children: [
                        OtpTextField(
                          numberOfFields: 4,
                          borderColor: Colors.transparent,
                          focusedBorderColor: AppColors.primary,
                          enabledBorderColor: Colors.transparent,
                          disabledBorderColor: Colors.transparent,
                          showFieldAsBox: true,
                          fieldWidth: 64.w,
                          fieldHeight: 56.h,
                          borderRadius: BorderRadius.circular(12.r),
                          filled: true,
                          fillColor: AppColors.primarySurface,
                          cursorColor: AppColors.primary,
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          handleControllers: controller.setOtpControllers,
                        ),
                        SizedBox(height: 20.h),
                        AppText(
                          data: 'A code has been sent to your email',
                          fontSize: 13.sp,
                          color: AppColors.gray,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Obx(
                          () => AppText(
                            data: controller.formattedTimer,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Obx(
                          () => AppButton(
                            title: 'Confirm',
                            isLoading: controller.isLoading.value,
                            onTap: controller.verify,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        AppText(
                          data: "Don't get OTP?",
                          fontSize: 13.sp,
                          color: AppColors.lightGray,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Obx(
                          () => GestureDetector(
                            onTap: controller.canResend.value
                                ? controller.resendOtp
                                : null,
                            child: AppText(
                              data: 'Resend',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: controller.canResend.value
                                  ? AppColors.black
                                  : AppColors.lightGray,
                              textAlign: TextAlign.center,
                            ),
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
