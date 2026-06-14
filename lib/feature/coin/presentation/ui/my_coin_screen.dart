import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/coin/domain/model/coin_transaction_item.dart';
import 'package:spendlock/feature/coin/presentation/controller/coin_controller.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_balance_card.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_transaction_tile.dart';

class MyCoinScreen extends GetView<CoinController> {
  const MyCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(text: 'My Coins', centerTitle: false),
      body: Obx(() {
        final isLoading = controller.isLoading.value;
        final coins = controller.coins;

        if (isLoading && coins.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return ListView(
          controller: controller.scrollController,
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          children: [
            Obx(
              () => CoinBalanceCard(
                balance: controller.coinBalance.value,
                showBuyButton: true,
                onBuyTap: () => Get.toNamed(AppRoutes.instance.buyCoinScreen),
              ),
            ),
            SizedBox(height: 20.h),
            if (coins.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: AppText(
                    data: 'No coin transactions yet',
                    fontSize: 14.sp,
                    color: AppColors.gray,
                    fontFamily: 'inter',
                  ),
                ),
              )
            else
              ...coins.map(
                (coin) => CoinTransactionTile(
                  item: CoinTransactionItem.fromCoinData(coin),
                ),
              ),
            if (controller.isLoadingMore.value)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
          ],
        );
      }),
    );
  }
}
