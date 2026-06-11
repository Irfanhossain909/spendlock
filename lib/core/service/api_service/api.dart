import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/utils/app_logger.dart';

class AppApi {
  final Dio _dio = Dio();
  var storageServices = GetStorageServices.instance;

  AppApi._privateConstructor() {
    _dio.options.baseUrl = AppApiEndPoint.instance.baseUrl;
    _dio.options.sendTimeout = const Duration(seconds: 120);
    _dio.options.connectTimeout = const Duration(seconds: 120);
    _dio.options.receiveTimeout = const Duration(seconds: 120);
    _dio.options.followRedirects = false;

    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = AppApiEndPoint.instance.baseUrl;
          options.contentType = 'application/json';
          options.headers["Accept"] = "application/json";

          String token = storageServices.getToken();
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (DioException error, handler) async {
          AppLogger.error("API error occurred:");
          AppLogger.error("Status code: ${error.response?.statusCode}");
          AppLogger.error("Error message: ${error.message}");

          try {
            if (error.response?.statusCode == 401) {
              AppLogger.error(
                "Unauthorized! Clearing storage and navigating to sign-in.",
              );
              await storageServices.clearSession();
              Get.offAllNamed(AppRoutes.instance.loginScreen);
              return handler.next(error);
            }

            if (error.response?.statusCode == 400) {
              // ❌ Snackbar removed from here
              if (error.response?.data["message"] != null) {
                Get.snackbar("Error", "${error.response?.data["message"]}");
              }

              AppLogger.error("error message: ${error.message}");
              return handler.next(error);
            }
          } catch (e) {
            AppLogger.error(e.toString());
            return handler.next(error);
          }

          return handler.next(error);
        },
      ),

      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          request: true,
          compact: true,
          error: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
    ]);
  }

  static final AppApi _instance = AppApi._privateConstructor();
  static AppApi get instance => _instance;

  Dio get sendRequest => _dio;
}
