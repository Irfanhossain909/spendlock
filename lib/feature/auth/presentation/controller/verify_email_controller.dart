import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/auth/domain/repository/auth_repository.dart';

class VerifyEmailController extends GetxController {
  static const int _otpTimerSeconds = 60;

  final isLoading = false.obs;
  final remainingSeconds = _otpTimerSeconds.obs;
  final canResend = false.obs;

  final AuthRepository authRepository = AuthRepository.instance;

  List<TextEditingController?>? _otpControllers;
  Timer? _timer;

  bool get isForgotPasswordFlow {
    final args = Get.arguments;
    if (args is Map) {
      return args['forgotPassword'] == true;
    }
    return args == true;
  }

  String get email {
    final args = Get.arguments;
    if (args is Map) {
      return args['email']?.toString().trim() ?? '';
    }
    return '';
  }

  String get formattedTimer {
    final minutes = (remainingSeconds.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void setOtpControllers(List<TextEditingController?> controllers) {
    _otpControllers = controllers;
  }

  String _readOtpFromFields() {
    final controllers = _otpControllers;
    if (controllers == null) return '';
    return controllers.map((c) => c?.text ?? '').join();
  }

  Future<void> resendOtp() async {
    if (!canResend.value || isLoading.value) return;

    if (email.isEmpty) {
      AppSnackBar.error('Email not found');
      return;
    }

    isLoading.value = true;
    try {
      final response = await authRepository.resendEmailOtp(email: email);
      if (response) {
        AppSnackBar.success('OTP sent to your email');
        _startTimer();
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verify([String? code]) async {
    final otp = (code ?? _readOtpFromFields()).trim();
    if (otp.length < 4) {
      AppSnackBar.error('Enter the 4-digit code');
      return;
    }

    isLoading.value = true;
    try {
      if (isForgotPasswordFlow) {
        Get.toNamed(AppRoutes.instance.resetPasswordScreen);
        return;
      }

      final response = await authRepository.emailVerify(otp: otp);
      if (response) {
        Get.offAllNamed(AppRoutes.instance.setGoalScreen);
      } else {
        AppSnackBar.error('Email verification failed');
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    remainingSeconds.value = _otpTimerSeconds;
    canResend.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        return;
      }
      canResend.value = true;
      timer.cancel();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
