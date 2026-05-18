import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_layout_tokens.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_slide_resolver.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.items.isEmpty) {
            return const Center(child: Text('No onboarding items'));
          }

          final items = controller.items;

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return OnboardingSlideResolver.resolve(
                      item: items[index],
                      totalPages: items.length,
                      activeIndex: controller.currentPage,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  OnboardingLayoutTokens.horizontalInset,
                  0,
                  OnboardingLayoutTokens.horizontalInset,
                  24.h,
                ),
                child: Obx(
                  () => AppButton(
                    title: controller.actionButtonLabel,
                    // showArrow: true,
                    onTap: controller.next,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
