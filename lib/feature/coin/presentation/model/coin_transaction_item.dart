import 'package:flutter/material.dart';

enum CoinTransactionType { purchase, earned, spent }

class CoinTransactionItem {
  const CoinTransactionItem({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.amount,
    required this.type,
  });

  final String title;
  final String subtitle;
  final String timestamp;
  final int amount;
  final CoinTransactionType type;

  bool get isPositive => amount > 0;

  IconData get icon {
    switch (type) {
      case CoinTransactionType.purchase:
        return Icons.monetization_on_outlined;
      case CoinTransactionType.earned:
        return Icons.star_outline;
      case CoinTransactionType.spent:
        return Icons.bar_chart_rounded;
    }
  }

  Color get iconBackground {
    switch (type) {
      case CoinTransactionType.purchase:
        return const Color(0xFFFFF4D6);
      case CoinTransactionType.earned:
        return const Color(0xFFF0F2F5);
      case CoinTransactionType.spent:
        return const Color(0xFFFFEBEE);
    }
  }

  Color get iconColor {
    switch (type) {
      case CoinTransactionType.purchase:
        return const Color(0xFFFFB800);
      case CoinTransactionType.earned:
        return const Color(0xFF041C37);
      case CoinTransactionType.spent:
        return const Color(0xFFD30000);
    }
  }
}
