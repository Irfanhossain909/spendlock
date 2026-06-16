import 'package:spendlock/core/service/api_service/api_services.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/service/storage/hive_service.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/rules/domain/mapper/rule_api_mapper.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/model/ruls_api_model.dart';

class RulesRepository {
  RulesRepository._();

  static final RulesRepository _instance = RulesRepository._();
  static RulesRepository get instance => _instance;

  final ApiServices apiServices = ApiServices.instance;

  /// GET → compare with local → replace or POST unsynced rules (parallel).
  Future<void> syncWithBackend() async {
    try {
      final apiModel = await getRules();
      final apiRules = apiModel?.data ?? <Datum>[];
      final localRules = getAllRules();
      final unsyncedRules =
          localRules.where((rule) => !rule.isSyncedToServer).toList();

      if (!RuleApiMapper.listsMatch(localRules, apiRules)) {
        await _replaceSyncedRulesWithApi(apiRules, unsyncedRules);
      }

      final pendingUpload = getAllRules()
          .where((rule) => !rule.isSyncedToServer)
          .toList();

      if (pendingUpload.isNotEmpty) {
        await Future.wait(pendingUpload.map(_uploadRuleToApi));
      }
    } catch (error) {
      AppLogger.error('Rules sync failed: $error');
    }
  }

  Future<void> _replaceSyncedRulesWithApi(
    List<Datum> apiRules,
    List<RuleModel> unsyncedRules,
  ) async {
    if (!HiveService.instance.isInitialized) return;

    try {
      final box = HiveService.instance.rulesBox;
      final keysToDelete = <dynamic>[];

      for (final key in box.keys) {
        final rule = _parseRule(box.get(key));
        if (rule != null && rule.isSyncedToServer) {
          keysToDelete.add(key);
        }
      }

      for (final key in keysToDelete) {
        await box.delete(key);
      }

      for (final datum in apiRules) {
        final mapped = RuleApiMapper.fromDatum(datum);
        await _saveRuleLocally(mapped);
      }

      for (final rule in unsyncedRules) {
        await _saveRuleLocally(rule);
      }
    } catch (error) {
      AppLogger.error('Failed to replace local rules from API: $error');
      rethrow;
    }
  }

  Future<String?> _uploadRuleToApi(RuleModel rule) async {
    final body = RuleApiMapper.toPostBody(rule);
    final serverId = await postRule(
      ruleType: body['ruleType'] as String,
      category: body['category'] as String,
      ruleName: body['ruleName'] as String,
      startTime: body['startTime'] as String,
      endTime: body['endTime'] as String,
      activeDays: List<String>.from(body['activeDays'] as List),
      selectedApps: List<String>.from(body['selectedApps'] as List),
      active: body['active'] as bool,
    );

    if (serverId == null || serverId.isEmpty) return null;

    final synced = rule.copyWith(
      id: serverId,
      serverId: serverId,
    );

    if (rule.id != serverId) {
      await HiveService.instance.rulesBox.delete(rule.id);
    }
    await _saveRuleLocally(synced);
    return serverId;
  }

  Future<bool> deleteRules(String id) async {
    try {
      final response = await apiServices.apiDeleteServices(
        url: '${AppApiEndPoint.instance.rules}/$id',
      );
      if (response is Map && response['success'] == true) {
        return true;
      }
    } catch (e) {
      AppLogger.error('Failed to delete rule: $e');
    }
    return false;
  }

  Future<RulsApiModel?> getRules() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.rules,
      );
      if (response is Map<String, dynamic> && response['data'] != null) {
        final data = response['data'];
        if (data is Map<String, dynamic>) {
          return RulsApiModel.fromJson(data);
        }
        if (data is List) {
          return RulsApiModel(
            data: data
                .whereType<Map<String, dynamic>>()
                .map(Datum.fromJson)
                .toList(),
          );
        }
      }
    } catch (e) {
      AppLogger.error('Failed to get rules: $e');
    }
    return null;
  }

  Future<String?> postRule({
    required String ruleType,
    required String category,
    required String ruleName,
    required String startTime,
    required String endTime,
    required List<String> activeDays,
    required List<String> selectedApps,
    required bool active,
  }) async {
    try {
      final body = {
        'ruleType': ruleType,
        'category': category,
        'ruleName': ruleName,
        'startTime': startTime,
        'endTime': endTime,
        'activeDays': activeDays,
        'selectedApps': selectedApps,
        'active': active,
      };
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.rules,
        body: body,
      );
      return _extractServerId(response);
    } catch (e) {
      AppLogger.error('Failed to post rule: $e');
    }
    return null;
  }

  Future<bool> updateRule({
    required String id,
    required bool active,
  }) async {
    try {
      final response = await apiServices.apiPatchServices(
        url: '${AppApiEndPoint.instance.rules}/$id',
        body: {'active': active},
      );
      if (response == null) return false;
      if (response is Map && response['success'] == false) return false;
      return true;
    } catch (e) {
      AppLogger.error('Failed to update rule: $e');
    }
    return false;
  }

  /// Hive box থেকে সব rules load করে
  List<RuleModel> getAllRules() {
    if (!HiveService.instance.isInitialized) {
      AppLogger.error('Hive is not initialized');
      return const [];
    }

    try {
      final box = HiveService.instance.rulesBox;
      final rules = <RuleModel>[];

      for (final key in box.keys) {
        final raw = box.get(key);
        final model = _parseRule(raw);
        if (model != null) rules.add(model);
      }

      rules.sort((a, b) => b.createdAtMillis.compareTo(a.createdAtMillis));
      return rules;
    } catch (error) {
      AppLogger.error('Failed to load rules: $error');
      return const [];
    }
  }

  /// Active rules only return করে
  List<RuleModel> getActiveRules() {
    return getAllRules().where((rule) => rule.isActive).toList();
  }

  /// ID দিয়ে single rule খুঁজে
  RuleModel? getRuleById(String id) {
    try {
      return _parseRule(HiveService.instance.rulesBox.get(id));
    } catch (error) {
      AppLogger.error('Failed to get rule: $error');
      return null;
    }
  }

  /// নতুন rule save/update করে — unsynced হলে API তে POST করে
  Future<void> saveRule(RuleModel rule) async {
    await _saveRuleLocally(rule);
    if (!rule.isSyncedToServer) {
      await _uploadRuleToApi(rule);
    }
  }

  /// Rule active/pause toggle করে — local + API PATCH
  Future<void> updateRuleActive(String id, bool isActive) async {
    final rule = getRuleById(id);
    if (rule == null) return;

    await _saveRuleLocally(rule.copyWith(isActive: isActive));

    final serverId = rule.serverId;
    if (serverId != null && serverId.isNotEmpty) {
      await updateRule(id: serverId, active: isActive);
      return;
    }

    if (!rule.isSyncedToServer) {
      final updated = getRuleById(id);
      if (updated != null) {
        await _uploadRuleToApi(updated.copyWith(isActive: isActive));
      }
    }
  }

  /// Rule delete করে — local + API DELETE
  Future<void> deleteRule(String id) async {
    final rule = getRuleById(id);

    try {
      final serverId = rule?.serverId;
      if (serverId != null && serverId.isNotEmpty) {
        await deleteRules(serverId);
      }
      await HiveService.instance.rulesBox.delete(id);
    } catch (error) {
      AppLogger.error('Failed to delete rule: $error');
      rethrow;
    }
  }

  /// Logout এর সময় সব locally saved rules clear করে
  Future<void> clearAllRules() async {
    if (!HiveService.instance.isInitialized) return;

    try {
      await HiveService.instance.rulesBox.clear();
    } catch (error) {
      AppLogger.error('Failed to clear rules: $error');
      rethrow;
    }
  }

  Future<void> _saveRuleLocally(RuleModel rule) async {
    try {
      await HiveService.instance.rulesBox.put(rule.id, rule.toJson());
    } catch (error) {
      AppLogger.error('Failed to save rule: $error');
      rethrow;
    }
  }

  String? _extractServerId(dynamic response) {
    if (response is! Map) return null;

    final data = response['data'];
    if (data is Map) {
      final id = data['_id'] ?? data['id'];
      if (id != null) return id.toString();
    }

    final id = response['_id'] ?? response['id'];
    return id?.toString();
  }

  RuleModel? _parseRule(dynamic raw) {
    if (raw is Map) {
      return RuleModel.fromJson(Map<String, dynamic>.from(raw));
    }
    return null;
  }
}
