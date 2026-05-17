import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/feature/onboarding/domain/model/onboarding_item_model.dart';
import 'package:spendlock/feature/onboarding/domain/repository/onboarding_repository.dart';

class OnboardingController extends GetxController {
  OnboardingController({OnboardingRepository? repository})
      : _repository = repository ?? OnboardingRepositoryImpl();

  final OnboardingRepository _repository;

  final pageController = PageController();
  final currentPage = 0.obs;
  final items = <OnboardingItemModel>[].obs;
  final isLoading = true.obs;

  bool get isLastPage =>
      items.isNotEmpty && currentPage.value >= items.length - 1;

  OnboardingItemModel? get currentItem {
    if (items.isEmpty || currentPage.value >= items.length) return null;
    return items[currentPage.value];
  }

  String get actionButtonLabel {
    final item = currentItem;
    if (item?.actionLabel != null) return item!.actionLabel!;
    return isLastPage ? 'Get Started' : 'Continue';
  }

  @override
  void onInit() {
    super.onInit();
    _loadItems();
  }

  Future<void> _loadItems() async {
    isLoading.value = true;
    items.assignAll(await _repository.getItems());
    isLoading.value = false;
  }

  void onPageChanged(int index) => currentPage.value = index;

  void next() {
    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }
    finishOnboarding();
  }

  Future<void> finishOnboarding() async {
    await GetStorageServices.instance.setOnboardingDone(true);
    Get.offAllNamed(AppRoutes.instance.loginScreen);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
