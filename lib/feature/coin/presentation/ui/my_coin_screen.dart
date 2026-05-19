import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/coin/presentation/model/coin_transaction_item.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_balance_card.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_transaction_tile.dart';

class MyCoinScreen extends StatelessWidget {
  const MyCoinScreen({super.key});

  static const int _balance = 12;

  static const List<CoinTransactionItem> _transactions = [
    CoinTransactionItem(
      title: 'Bought coins',
      subtitle: '15 coins + 2 bonus pack',
      timestamp: 'Today, 10:30 AM',
      amount: 17,
      type: CoinTransactionType.purchase,
    ),
    CoinTransactionItem(
      title: 'Earned coin',
      subtitle: '7-day streak reward',
      timestamp: 'Yesterday, 9:15 AM',
      amount: 1,
      type: CoinTransactionType.earned,
    ),
    CoinTransactionItem(
      title: 'Unlocked Uber Eats',
      subtitle: 'Spent 1 coin to unlock',
      timestamp: 'Mon, 6:42 PM',
      amount: -1,
      type: CoinTransactionType.spent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(text: 'My Coins', centerTitle: false),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        children: [
          CoinBalanceCard(
            balance: _balance,
            showBuyButton: true,
            onBuyTap: () => Get.toNamed(AppRoutes.instance.buyCoinScreen),
          ),
          SizedBox(height: 20.h),
          ..._transactions.map(
            (item) => CoinTransactionTile(item: item),
          ),
        ],
      ),
    );
  }
}
