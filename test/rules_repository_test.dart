import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/repository/rules_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RulesRepository', () {
    late Box box;

    setUp(() async {
      Hive.init('./.dart_tool/test_hive');
      box = await Hive.openBox('test_rules_json_box');
    });

    tearDown(() async {
      await box.clear();
      await box.close();
    });

    test('save and load rule json', () async {
      final rule = RuleModel(
        id: '123',
        type: 0,
        name: 'No social after 9pm',
        categoryIds: const ['social'],
        timeFromMinutes: RuleModel.timeOfDayToMinutes(
          const TimeOfDay(hour: 21, minute: 0),
        ),
        timeToMinutes: RuleModel.timeOfDayToMinutes(
          const TimeOfDay(hour: 8, minute: 0),
        ),
        activeDayIndices: const [1, 2, 3, 4, 5],
        packageNames: const ['com.whatsapp'],
        createdAtMillis: DateTime.now().millisecondsSinceEpoch,
      );

      await box.put(rule.id, rule.toJson());

      final raw = box.get('123');
      expect(raw, isA<Map>());

      final loaded = RuleModel.fromJson(Map<String, dynamic>.from(raw as Map));
      expect(loaded.name, 'No social after 9pm');
      expect(loaded.packageNames, ['com.whatsapp']);
    });
  });
}
