import 'package:flutter/material.dart';
import 'package:spendlock/core/const/app_color.dart';

typedef PreferenceOption = (IconData icon, String title, Color color);

class PreferenceOptions {
  PreferenceOptions._();

  static const goals = <PreferenceOption>[
    (Icons.savings_outlined, 'Save more money', AppColors.primary),
    (Icons.remove_shopping_cart_outlined, 'Stop impulse buying', Colors.orange),
    (Icons.show_chart_rounded, 'Track spending', Colors.blueAccent),
    (Icons.bolt, 'Build better habits', AppColors.redBrown),
  ];

  static const triggers = <PreferenceOption>[
    (Icons.nights_stay_outlined, 'Late-night food delivery', AppColors.primary),
    (Icons.remove_shopping_cart_outlined, 'Online shopping sprees', Colors.red),
    (Icons.coffee_outlined, 'Coffee & cafes', Colors.brown),
    (Icons.tv, 'Entertainment', AppColors.blueAccent),
    (Icons.more_horiz, 'Something else', Colors.grey),
  ];
}
