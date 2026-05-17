import 'package:flutter/material.dart' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:spendlock/core/const/app_color.dart';

void main() {
  test('SpendLock brand colors are defined', () {
    expect(AppColors.primary, const Color(0xFF0E8279));
  });
}
