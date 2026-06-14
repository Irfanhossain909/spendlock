import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/web_view/stripe_web_view_page.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/coin/domain/model/coin_model.dart';
import 'package:spendlock/feature/coin/domain/model/coin_package_model.dart';
import 'package:spendlock/feature/coin/domain/repository/coin_repository.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';

class CoinController extends GetxController {
  final CoinRepository coinRepository = CoinRepository.instance;

  final RxList<CoinDataModel> coins = <CoinDataModel>[].obs;
  final RxList<CoinPackageDataModel> packages = <CoinPackageDataModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool isPackageLoading = false.obs;
  final RxBool isPackageLoadingMore = false.obs;
  final RxBool isBuying = false.obs;
  final RxInt coinBalance = 0.obs;
  final RxnString selectCoinPackageId = RxnString();

  final ScrollController scrollController = ScrollController();
  final ScrollController packageScrollController = ScrollController();

  int page = 1;
  int limit = 10;
  int? totalPage;

  int packagePage = 1;
  int packageLimit = 10;
  int? packageTotalPage;

  bool get hasMore => totalPage == null || page < totalPage!;
  bool get hasMorePackages =>
      packageTotalPage == null || packagePage < packageTotalPage!;

  CoinPackageDataModel? get selectedPackage {
    final id = selectCoinPackageId.value;
    if (id == null) return null;

    for (final package in packages) {
      if (package.id == id) return package;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    _loadCoinBalance();
    getCoins();
    scrollController.addListener(_onScroll);
    packageScrollController.addListener(_onPackageScroll);

    if (Get.isRegistered<ProfileController>()) {
      ever(Get.find<ProfileController>().profile, (_) => _loadCoinBalance());
    }
  }

  void _loadCoinBalance() {
    if (Get.isRegistered<ProfileController>()) {
      coinBalance.value =
          Get.find<ProfileController>().profile.value?.data?.coinBalance ?? 0;
    }
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final threshold = scrollController.position.maxScrollExtent - 200;
    if (scrollController.position.pixels >= threshold) {
      loadMore();
    }
  }

  void _onPackageScroll() {
    if (!packageScrollController.hasClients) return;

    final threshold = packageScrollController.position.maxScrollExtent - 200;
    if (packageScrollController.position.pixels >= threshold) {
      loadMorePackages();
    }
  }

  void selectCoinPackage(String? id) {
    selectCoinPackageId.value = id;
  }

  Future<void> buyCoin({required BuildContext context}) async {
    final packageId = selectCoinPackageId.value;
    if (packageId == null || packageId.isEmpty) {
      AppSnackBar.error('Please select a package');
      return;
    }

    try {
      isBuying.value = true;

      final paymentUrl = await coinRepository.addCoin(packageId: packageId);
      if (paymentUrl == null) {
        AppSnackBar.error('Failed to start payment');
        return;
      }

      await openStripePayment(
        context: context,
        paymentUrl: paymentUrl,
        successUrl: '/package_success',
        cancelUrl: '/coin',
      );
    } catch (e) {
      AppLogger.error(e.toString());
      AppSnackBar.error('Something went wrong');
    } finally {
      isBuying.value = false;
    }
  }

  Future<void> openStripePayment({
    required BuildContext context,
    required String paymentUrl,
    required String successUrl,
    required String cancelUrl,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StripeWebViewPage(
          paymentUrl: paymentUrl,
          successEndpoint: successUrl,
          cancelEndpoint: cancelUrl,
        ),
      ),
    );

    if (!context.mounted || result == null) return;

    if (result['status'] == 'success') {
      AppSnackBar.success('Coins purchased successfully!');

      if (Get.isRegistered<ProfileController>()) {
        await Get.find<ProfileController>().getProfile();
      }
      await getCoins(refresh: true);
      Get.back();
    } else {
      AppSnackBar.error('Payment cancelled');
    }
  }

  Future<void> getCoins({bool refresh = false}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      if (refresh) {
        page = 1;
        totalPage = null;
      }

      final response = await coinRepository.getCoins(page: page, limit: limit);
      if (response != null) {
        totalPage = response.pagination?.totalPage;
        coins.assignAll(response.data ?? []);
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || isLoading.value || !hasMore) return;

    try {
      isLoadingMore.value = true;
      page++;

      final response = await coinRepository.getCoins(page: page, limit: limit);
      if (response != null) {
        totalPage = response.pagination?.totalPage;
        coins.addAll(response.data ?? []);
      } else {
        page--;
      }
    } catch (e) {
      page--;
      AppLogger.error(e.toString());
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> getCoinPackages({bool refresh = false}) async {
    if (isPackageLoading.value) return;

    try {
      isPackageLoading.value = true;

      if (refresh) {
        packagePage = 1;
        packageTotalPage = null;
      }

      final response = await coinRepository.getCoinPackages(
        page: packagePage,
        limit: packageLimit,
      );

      if (response != null) {
        packageTotalPage = response.pagination?.totalPage;
        packages.assignAll(response.data ?? []);

        if (selectCoinPackageId.value == null && packages.isNotEmpty) {
          selectCoinPackageId.value = packages.first.id;
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isPackageLoading.value = false;
    }
  }

  Future<void> loadMorePackages() async {
    if (isPackageLoadingMore.value ||
        isPackageLoading.value ||
        !hasMorePackages) {
      return;
    }

    try {
      isPackageLoadingMore.value = true;
      packagePage++;

      final response = await coinRepository.getCoinPackages(
        page: packagePage,
        limit: packageLimit,
      );

      if (response != null) {
        packageTotalPage = response.pagination?.totalPage;
        packages.addAll(response.data ?? []);
      } else {
        packagePage--;
      }
    } catch (e) {
      packagePage--;
      AppLogger.error(e.toString());
    } finally {
      isPackageLoadingMore.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    packageScrollController.dispose();
    super.onClose();
  }
}
