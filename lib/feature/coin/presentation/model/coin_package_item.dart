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

  String get priceLabel => '\$${price.toStringAsFixed(2)}';

  String get coinsLabel => '$coins coins';
}
