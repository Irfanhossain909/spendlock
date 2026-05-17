import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/spendlock_branding.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/splash/presentation/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (_) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: SpendLockBranding(
            logoSize: 123,
            showTagline: true,
            centered: true,
          ),
        ),
      ),
    );
  }
}
