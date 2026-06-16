import 'package:spendlock/core/utils/rule_time_utils.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/model/rule_type.dart';
import 'package:spendlock/feature/rules/domain/model/ruls_api_model.dart';

class RuleApiMapper {
  RuleApiMapper._();

  static const _dayKeys = [
    'sun',
    'mon',
    'tue',
    'wed',
    'thu',
    'fri',
    'sat',
  ];

  static const _dayAliases = {
    'sun': 0,
    'sunday': 0,
    's': 0,
    'mon': 1,
    'monday': 1,
    'm': 1,
    'tue': 2,
    'tuesday': 2,
    't': 2,
    'wed': 3,
    'wednesday': 3,
    'w': 3,
    'thu': 4,
    'thursday': 4,
    'th': 4,
    'fri': 5,
    'friday': 5,
    'f': 5,
    'sat': 6,
    'saturday': 6,
    'sa': 6,
  };

  /// API Datum → local Hive model.
  static RuleModel fromDatum(Datum datum) {
    final serverId = datum.id ?? '';
    return RuleModel(
      id: serverId.isNotEmpty ? serverId : _fallbackLocalId(datum),
      serverId: serverId.isNotEmpty ? serverId : null,
      type: _ruleTypeFromApi(datum.ruleType),
      name: datum.ruleName ?? '',
      categoryIds: datum.category == null || datum.category!.isEmpty
          ? const []
          : [datum.category!],
      timeFromMinutes: _timeToMinutes(datum.startTime),
      timeToMinutes: _timeToMinutes(datum.endTime),
      activeDayIndices: _activeDaysToIndices(datum.activeDays),
      spendingLimitAmount: datum.spendingLimit?.toDouble(),
      spendingLimitFrequency: datum.spendingLimit != null
          ? SpendingLimitFrequency.perDay.storageIndex
          : null,
      packageNames: List<String>.from(datum.selectedApps ?? const []),
      isActive: datum.active ?? true,
      createdAtMillis: datum.createdAt?.millisecondsSinceEpoch ??
          RuleTimeUtils.currentLocalNow.millisecondsSinceEpoch,
      timezoneName: RuleTimeUtils.deviceTimezoneName,
      timezoneOffsetMinutes: RuleTimeUtils.deviceTimezoneOffsetMinutes,
    );
  }

  /// Local model → API POST body fields.
  static Map<String, dynamic> toPostBody(RuleModel rule) {
    return {
      'ruleType': _ruleTypeToApi(rule.type),
      'category': rule.categoryIds.isNotEmpty ? rule.categoryIds.first : '',
      'ruleName': rule.name,
      'startTime': _minutesToTime(rule.timeFromMinutes),
      'endTime': _minutesToTime(rule.timeToMinutes),
      'activeDays': _indicesToActiveDays(rule.activeDayIndices),
      'selectedApps': rule.packageNames,
      'active': rule.isActive,
    };
  }

  /// Compare synced local rules with API list (ignores unsynced local rules).
  static bool listsMatch(List<RuleModel> localRules, List<Datum> apiRules) {
    final syncedLocal = localRules.where((rule) => rule.isSyncedToServer).toList();
    if (syncedLocal.length != apiRules.length) return false;

    final apiById = {
      for (final datum in apiRules)
        if (datum.id != null && datum.id!.isNotEmpty) datum.id!: datum,
    };

    if (apiById.length != apiRules.length) return false;

    for (final local in syncedLocal) {
      final remote = apiById[local.serverId];
      if (remote == null || !_datumMatchesLocal(remote, local)) {
        return false;
      }
    }

    return true;
  }

  static bool _datumMatchesLocal(Datum datum, RuleModel local) {
    final mapped = fromDatum(datum);
    return mapped.name == local.name &&
        mapped.type == local.type &&
        mapped.isActive == local.isActive &&
        mapped.timeFromMinutes == local.timeFromMinutes &&
        mapped.timeToMinutes == local.timeToMinutes &&
        _sorted(mapped.categoryIds) == _sorted(local.categoryIds) &&
        _sorted(mapped.packageNames) == _sorted(local.packageNames) &&
        _sorted(mapped.activeDayIndices) == _sorted(local.activeDayIndices);
  }

  static List<T> _sorted<T extends Comparable<T>>(List<T> values) {
    final copy = List<T>.from(values)..sort();
    return copy;
  }

  static String _ruleTypeToApi(int type) {
    return RuleTypeStorage.fromStorageIndex(type) == RuleType.limitBased
        ? 'limitBased'
        : 'timeBased';
  }

  static int _ruleTypeFromApi(String? value) {
    final normalized = value?.toLowerCase().trim();
    if (normalized == 'limitbased' || normalized == 'limit_based') {
      return RuleType.limitBased.storageIndex;
    }
    return RuleType.timeBased.storageIndex;
  }

  static String _minutesToTime(int minutes) {
    final normalized = minutes % (24 * 60);
    final hours = normalized ~/ 60;
    final mins = normalized % 60;
    return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
  }

  static int _timeToMinutes(String? value) {
    if (value == null || value.isEmpty) return 0;
    final parts = value.split(':');
    if (parts.length < 2) return 0;
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    return (hours * 60) + minutes;
  }

  static List<String> _indicesToActiveDays(List<int> indices) {
    return indices
        .where((index) => index >= 0 && index < _dayKeys.length)
        .map((index) => _dayKeys[index])
        .toList();
  }

  static List<int> _activeDaysToIndices(List<String>? days) {
    if (days == null || days.isEmpty) return const [];
    final indices = <int>{};
    for (final day in days) {
      final index = _dayAliases[day.toLowerCase().trim()];
      if (index != null) indices.add(index);
    }
    return indices.toList()..sort();
  }

  static String _fallbackLocalId(Datum datum) {
    return datum.createdAt?.millisecondsSinceEpoch.toString() ??
        RuleTimeUtils.currentLocalNow.millisecondsSinceEpoch.toString();
  }
}
