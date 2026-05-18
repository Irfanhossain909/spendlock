import 'dart:async';

import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';

class VerifyEmailController extends GetxController {
  static const int _otpTimerSeconds = 60;

  final isLoading = false.obs;
  final remainingSeconds = _otpTimerSeconds.obs;
  final canResend = false.obs;

  String _otpCode = '';
  Timer? _timer;

  bool get isForgotPasswordFlow {
    final args = Get.arguments;
    if (args is Map) {
      return args['forgotPassword'] == true;
    }
    return args == true;
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

  void onOtpChanged(String code) {
    _otpCode = code;
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;
    AppSnackBar.success('OTP sent to your email');
    _startTimer();
  }

  Future<void> verify([String? code]) async {
    final otp = (code ?? _otpCode).trim();
    if (otp.length < 4) {
      AppSnackBar.error('Enter the 4-digit code');
      return;
    }
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;

    if (isForgotPasswordFlow) {
      Get.toNamed(AppRoutes.instance.resetPasswordScreen);
      return;
    }

    await GetStorageServices.instance.setToken('verified_token');
    await GetStorageServices.instance.setName('Sarah Leo');
    Get.offAllNamed(AppRoutes.instance.setGoalScreen);
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
