import 'package:flutter/foundation.dart';
import 'package:spendlock/core/utils/app_logger.dart';

class AppApiEndPoint {
  AppApiEndPoint._privateConstructor();
  static final AppApiEndPoint _instance = AppApiEndPoint._privateConstructor();
  static AppApiEndPoint get instance => _instance;

  //app use base
  static final String domain = _getDomain();
  static final String socketDomain = getSocketUrl();
  final String baseUrl = "$domain/api/v1";
  final String refreshToken = "/auth/refresh-token";

  ////Auth/////////////
  final String googleAuth = "/auth/google";
  final String login = "/auth/login";
  final String signUp = "/user";
  final String verifyEmailOtp = "/auth/verify-email";
  final String resendEmailOtp = "/auth/resend-otp";
  final String forgetPass = "/auth/forget-password";
  final String resetPass = "/auth/reset-password";
  ////in app Url/////////////

  //////Profile/////////////
  final String profile = "/user/profile";
  final String changePassword = "/auth/change-password";
  static String coinList(var page, var limit) =>
      "/coin-history?page=$page&limit=$limit";
  static String coinPackageList(var page, var limit) =>
      "/package?page=$page&limit=$limit";
  final String addCoin = "/package/create-checkout";

  static String motivationList(var page, var limit) =>
      "/motivation?page=$page&limit=$limit";
  static String triggerList(var page, var limit) =>
      "/trigger?page=$page&limit=$limit";
}

// Move this function outside the class
String _getDomain() {
  String liveServer = "http://10.10.26.166:5001";
  String localServer = "http://10.10.26.166:5001";
  try {
    if (kDebugMode) {
      return localServer;
    }
    return liveServer;
  } catch (e) {
    AppLogger.error(e.toString());
    return liveServer;
  }
  // return liveServer;
}

String getSocketUrl() {
  String liveSocket = "http://10.10.7.11:5001";
  String localSocket = "http://10.10.7.11:5001";
  try {
    if (kDebugMode) {
      return localSocket;
    }
    return liveSocket;
  } catch (e) {
    AppLogger.error(e.toString());
    return liveSocket;
  }
}
