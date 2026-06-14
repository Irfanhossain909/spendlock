import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/coin/domain/model/coin_package_item.dart';
import 'package:spendlock/feature/coin/presentation/controller/coin_controller.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_balance_card.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_package_tile.dart';

class BuyCoinScreen extends StatefulWidget {
  const BuyCoinScreen({super.key});

  @override
  State<BuyCoinScreen> createState() => _BuyCoinScreenState();
}

class _BuyCoinScreenState extends State<BuyCoinScreen> {
  late final CoinController controller = Get.find<CoinController>();

  @override
  void initState() {
    super.initState();
    controller.getCoinPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(text: 'Buy Coins', centerTitle: false),
      body: Obx(() {
        final isLoading = controller.isPackageLoading.value;
        final packages = controller.packages;
        final selectedPackage = controller.selectedPackage;

        return Column(
          children: [
            Expanded(
              child: isLoading && packages.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : ListView(
                      controller: controller.packageScrollController,
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                      children: [
                        Obx(
                          () => CoinBalanceCard(
                            balance: controller.coinBalance.value,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        if (packages.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.h),
                            child: Center(
                              child: AppText(
                                data: 'No coin packages available',
                                fontSize: 14.sp,
                                color: AppColors.gray,
                                fontFamily: 'inter',
                              ),
                            ),
                          )
                        else
                          ...packages.map((package) {
                            final item = CoinPackageItem.fromPackageData(
                              package,
                            );

                            return CoinPackageTile(
                              package: item,
                              isSelected:
                                  controller.selectCoinPackageId.value ==
                                  package.id,
                              onTap: () =>
                                  controller.selectCoinPackage(package.id),
                            );
                          }),
                        if (controller.isPackageLoadingMore.value)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                child: AppButton(
                  title: selectedPackage == null
                      ? 'Select a package'
                      : 'Buy ${selectedPackage.coins} coins for \$${selectedPackage.price?.toStringAsFixed(2)}',
                  isLoading: controller.isBuying.value,
                  onTap: selectedPackage == null
                      ? null
                      : () => controller.buyCoin(context: context),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
