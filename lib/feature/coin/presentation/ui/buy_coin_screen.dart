import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/coin/presentation/model/coin_package_item.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_balance_card.dart';
import 'package:spendlock/feature/coin/presentation/widget/coin_package_tile.dart';

class BuyCoinScreen extends StatefulWidget {
  const BuyCoinScreen({super.key});

  @override
  State<BuyCoinScreen> createState() => _BuyCoinScreenState();
}

class _BuyCoinScreenState extends State<BuyCoinScreen> {
  static const int _balance = 12;

  static const List<CoinPackageItem> _packages = [
    CoinPackageItem(
      coins: 5,
      price: 4.99,
      subtitle: 'Standard start',
    ),
    CoinPackageItem(
      coins: 15,
      price: 14.99,
      subtitle: 'Save 25%',
      highlightSubtitle: true,
    ),
    CoinPackageItem(
      coins: 30,
      price: 24.99,
      subtitle: 'Best value',
      highlightSubtitle: true,
    ),
    CoinPackageItem(
      coins: 50,
      price: 39.99,
      subtitle: 'Power pack',
    ),
  ];

  int _selectedIndex = 1;

  CoinPackageItem get _selectedPackage => _packages[_selectedIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbar(text: 'Buy Coins', centerTitle: false),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              children: [
                const CoinBalanceCard(balance: _balance),
                SizedBox(height: 20.h),
                ...List.generate(_packages.length, (index) {
                  return CoinPackageTile(
                    package: _packages[index],
                    isSelected: _selectedIndex == index,
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                }),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: AppButton(
                title:
                    'Buy ${_selectedPackage.coins} coins for ${_selectedPackage.priceLabel}',
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
