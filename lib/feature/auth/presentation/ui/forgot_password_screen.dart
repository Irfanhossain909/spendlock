import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_input/app_input_field.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/component/spendlock_branding.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (_emailController.text.trim().isEmpty) {
      AppSnackBar.error('Enter your email');
      return;
    }
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    setState(() => _loading = false);
    AppSnackBar.success('OTP sent to your email');
    Get.back();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpendLockBranding(logoSize: 48),
              SizedBox(height: 16.h),
              AppText(data: 'Forgot Password', fontSize: 24.sp, fontWeight: FontWeight.w700),
              SizedBox(height: 8.h),
              AppText(
                data: 'Enter your email and get OTP for verification',
                fontSize: 14.sp,
                color: AppColors.gray,
                maxLines: 2,
              ),
              SizedBox(height: 24.h),
              AuthFormCard(
                child: Column(
                  children: [
                    AppInputField(
                      label: 'Email',
                      hint: 'Enter your email',
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      title: 'Send OTP',
                      isLoading: _loading,
                      showArrow: true,
                      onTap: _submit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
