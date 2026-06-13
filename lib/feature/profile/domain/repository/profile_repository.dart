import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:spendlock/core/service/api_service/api_services.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/profile/presentation/model/profile_model.dart';

class ProfileRepository {
  ProfileRepository._();
  static final ProfileRepository _instance = ProfileRepository._();
  static ProfileRepository get instance => _instance;

  final ApiServices apiServices = ApiServices.instance;

  Future<ProfileModel?> getProfile() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.profile,
      );
      if (response == null || response is! Map) {
        return null;
      }
      final map = Map<String, dynamic>.from(response);
      if (map["success"] == true) {
        return ProfileModel.fromJson(map);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }

  Future<bool> updateUserProfile({
    String? name,
    String? image,
    String? motivation,
    String? trigger,
    int? budget,
  }) async {
    try {
      final Map<String, dynamic> data = {};

      if (name != null && name.isNotEmpty) {
        data["name"] = name;
      }

      // Preference Object
      final Map<String, dynamic> preference = {};

      if (motivation != null) {
        preference["motivation"] = motivation;
      }

      if (trigger != null) {
        preference["trigger"] = trigger;
      }

      if (budget != null) {
        preference["budget"] = budget;
      }

      if (preference.isNotEmpty) {
        data["preference"] = jsonEncode(preference);
      }

      final FormData formData = FormData.fromMap(data);

      // Image Upload
      if (image != null && image.isNotEmpty) {
        final file = File(image);

        if (await file.exists()) {
          final fileName = file.path.split('/').last;
          final mimeType = lookupMimeType(file.path);

          formData.files.add(
            MapEntry(
              "image",
              await MultipartFile.fromFile(
                file.path,
                filename: fileName,
                contentType: MediaType.parse(
                  mimeType ?? "application/octet-stream",
                ),
              ),
            ),
          );
        }
      }

      final response = await apiServices.apiPatchServices(
        url: AppApiEndPoint.instance.profile,
        body: formData,
      );

      if (response == null || response is! Map) {
        return false;
      }

      final map = Map<String, dynamic>.from(response);
      return map['success'] == true;
    } catch (e) {
      AppLogger.error(e.toString());
      return false;
    }
  }
}
