import 'package:flutter/material.dart';
import 'package:spendlock/core/utils/rule_time_utils.dart';
import 'package:spendlock/feature/rules/domain/model/rule_type.dart';

class RuleModel {
  const RuleModel({
    required this.id,
    required this.type,
    required this.name,
    required this.categoryIds,
    required this.timeFromMinutes,
    required this.timeToMinutes,
    required this.activeDayIndices,
    this.spendingLimitAmount,
    this.spendingLimitFrequency,
    required this.packageNames,
    this.isActive = true,
    required this.createdAtMillis,
    this.timezoneName,
    this.timezoneOffsetMinutes,
  });

  final String id;
  final int type;
  final String name;
  final List<String> categoryIds;
  final int timeFromMinutes;
  final int timeToMinutes;
  final List<int> activeDayIndices;
  final double? spendingLimitAmount;
  final int? spendingLimitFrequency;
  final List<String> packageNames;
  final bool isActive;
  final int createdAtMillis;
  final String? timezoneName;
  final int? timezoneOffsetMinutes;

  RuleType get ruleType => RuleTypeStorage.fromStorageIndex(type);

  bool get isTimeBased => ruleType == RuleType.timeBased;

  bool get isLimitBased => ruleType == RuleType.limitBased;

  TimeOfDay get timeFrom => _minutesToTimeOfDay(timeFromMinutes);

  TimeOfDay get timeTo => _minutesToTimeOfDay(timeToMinutes);

  SpendingLimitData? get spendingLimit {
    final frequency = SpendingLimitFrequencyStorage.fromStorageIndex(
      spendingLimitFrequency,
    );
    if (spendingLimitAmount == null || frequency == null) return null;
    return SpendingLimitData(amount: spendingLimitAmount!, frequency: frequency);
  }

  factory RuleModel.fromJson(Map<String, dynamic> json) {
    return RuleModel(
      id: json['id']?.toString() ?? '',
      type: (json['type'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      categoryIds: _readStringList(json['categoryIds']),
      timeFromMinutes: (json['timeFromMinutes'] as num?)?.toInt() ?? 0,
      timeToMinutes: (json['timeToMinutes'] as num?)?.toInt() ?? 0,
      activeDayIndices: _readIntList(json['activeDayIndices']),
      spendingLimitAmount: (json['spendingLimitAmount'] as num?)?.toDouble(),
      spendingLimitFrequency: (json['spendingLimitFrequency'] as num?)?.toInt(),
      packageNames: _readStringList(json['packageNames']),
      isActive: _readBool(json['isActive'], defaultValue: true),
      createdAtMillis:
          (json['createdAtMillis'] as num?)?.toInt() ??
          RuleTimeUtils.currentLocalNow.millisecondsSinceEpoch,
      timezoneName: json['timezoneName']?.toString(),
      timezoneOffsetMinutes:
          (json['timezoneOffsetMinutes'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'categoryIds': categoryIds,
      'timeFromMinutes': timeFromMinutes,
      'timeToMinutes': timeToMinutes,
      'activeDayIndices': activeDayIndices,
      'spendingLimitAmount': spendingLimitAmount,
      'spendingLimitFrequency': spendingLimitFrequency,
      'packageNames': packageNames,
      'isActive': isActive,
      'createdAtMillis': createdAtMillis,
      'timezoneName': timezoneName,
      'timezoneOffsetMinutes': timezoneOffsetMinutes,
    };
  }

  String get timezoneLabel {
    if (timezoneName != null && timezoneOffsetMinutes != null) {
      final offset = Duration(minutes: timezoneOffsetMinutes!);
      final sign = offset.isNegative ? '-' : '+';
      final totalMinutes = offset.inMinutes.abs();
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      return '$timezoneName (UTC$sign${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')})';
    }
    return RuleTimeUtils.deviceTimezoneLabel;
  }

  RuleModel copyWith({
    String? id,
    int? type,
    String? name,
    List<String>? categoryIds,
    int? timeFromMinutes,
    int? timeToMinutes,
    List<int>? activeDayIndices,
    double? spendingLimitAmount,
    int? spendingLimitFrequency,
    List<String>? packageNames,
    bool? isActive,
    int? createdAtMillis,
    String? timezoneName,
    int? timezoneOffsetMinutes,
  }) {
    return RuleModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      categoryIds: categoryIds ?? List<String>.from(this.categoryIds),
      timeFromMinutes: timeFromMinutes ?? this.timeFromMinutes,
      timeToMinutes: timeToMinutes ?? this.timeToMinutes,
      activeDayIndices:
          activeDayIndices ?? List<int>.from(this.activeDayIndices),
      spendingLimitAmount: spendingLimitAmount ?? this.spendingLimitAmount,
      spendingLimitFrequency:
          spendingLimitFrequency ?? this.spendingLimitFrequency,
      packageNames: packageNames ?? List<String>.from(this.packageNames),
      isActive: isActive ?? this.isActive,
      createdAtMillis: createdAtMillis ?? this.createdAtMillis,
      timezoneName: timezoneName ?? this.timezoneName,
      timezoneOffsetMinutes:
          timezoneOffsetMinutes ?? this.timezoneOffsetMinutes,
    );
  }

  static List<String> _readStringList(dynamic value) {
    if (value is! List) return const [];
    return value.map((item) => item.toString()).toList();
  }

  static List<int> _readIntList(dynamic value) {
    if (value is! List) return const [];
    return value.map((item) => (item as num).toInt()).toList();
  }

  static bool _readBool(dynamic value, {required bool defaultValue}) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.toLowerCase();
      if (normalized == 'true' || normalized == '1') return true;
      if (normalized == 'false' || normalized == '0') return false;
    }
    return defaultValue;
  }

  static int timeOfDayToMinutes(TimeOfDay time) => RuleTimeUtils.toMinutes(time);

  static TimeOfDay _minutesToTimeOfDay(int minutes) {
    final normalized = minutes % (24 * 60);
    return TimeOfDay(hour: normalized ~/ 60, minute: normalized % 60);
  }
}
