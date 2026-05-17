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
    return GetBuilder<VerifyEmailController>(
      init: VerifyEmailController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
              onPressed: Get.back,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(gradient: AppColors.authBackground),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                children: [
                  SpendLockBranding(logoSize: 66, centered: true),
                  SizedBox(height: 16.h),
                  AppText(
                    data: 'Verify Email',
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
                          borderColor: AppColors.stroke,
                          focusedBorderColor: AppColors.primary,
                          showFieldAsBox: true,
                          fieldWidth: 70.w,
                          borderRadius: BorderRadius.circular(12.r),
                          onSubmit: controller.verify,
                        ),
                        SizedBox(height: 24.h),
                        Obx(
                          () => AppButton(
                            title: 'Verify',
                            isLoading: controller.isLoading.value,
                            showArrow: true,
                            onTap: () => controller.verify('1234'),
                          ),
                        ),
                      ],
                    ),
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
