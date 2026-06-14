import 'package:flutter/material.dart';
import 'package:spendlock/feature/coin/domain/model/coin_model.dart';

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

  factory CoinTransactionItem.fromCoinData(CoinDataModel data) {
    final typeStr = (data.type ?? '').toLowerCase();
    final CoinTransactionType type;
    int amount = data.coins ?? 0;

    if (typeStr.contains('purchase') ||
        typeStr.contains('bought') ||
        typeStr.contains('buy')) {
      type = CoinTransactionType.purchase;
      amount = amount.abs();
    } else if (typeStr.contains('spend') ||
        typeStr.contains('unlock') ||
        typeStr.contains('deduct')) {
      type = CoinTransactionType.spent;
      amount = -amount.abs();
    } else {
      type = CoinTransactionType.earned;
      amount = amount.abs();
    }

    return CoinTransactionItem(
      title: data.title ?? 'Coin transaction',
      subtitle: data.description ?? '',
      timestamp: _formatTimestamp(data.createdAt),
      amount: amount,
      type: type,
    );
  }

  static String _formatTimestamp(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    final time = '$hour:$minute $period';

    if (dateOnly == today) return 'Today, $time';
    if (dateOnly == yesterday) return 'Yesterday, $time';

    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[date.weekday - 1]}, $time';
  }

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
