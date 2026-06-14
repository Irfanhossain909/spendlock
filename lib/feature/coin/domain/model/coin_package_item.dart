import 'package:spendlock/feature/coin/domain/model/coin_package_model.dart';

class CoinPackageItem {
  const CoinPackageItem({
    required this.coins,
    required this.price,
    this.subtitle,
    this.highlightSubtitle = false,
  });

  final int coins;
  final double price;
  final String? subtitle;
  final bool highlightSubtitle;

  factory CoinPackageItem.fromPackageData(CoinPackageDataModel data) {
    final discount = data.discount ?? 0;
    String? subtitle;
    var highlightSubtitle = false;

    if (discount > 0) {
      subtitle = 'Save $discount%';
      highlightSubtitle = true;
    }

    return CoinPackageItem(
      coins: data.coins ?? 0,
      price: data.price ?? 0,
      subtitle: subtitle,
      highlightSubtitle: highlightSubtitle,
    );
  }

  String get priceLabel => '\$${price.toStringAsFixed(2)}';

  String get coinsLabel => '$coins coins';
}
