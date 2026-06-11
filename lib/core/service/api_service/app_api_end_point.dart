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
  final String signUp = "/users";
  final String verifyEmailOtp = "/auth/verify-email";
  final String verifyPhoneOtp = "/auth/verify-phone";
  final String resendEmailOtp = "/auth/resend-email-otp";
  final String resendPhoneOtp = "/auth/resend-phone-otp";
  final String forgotPassword = "/auth/forget-password";
  final String resetPassword = "/auth/reset-password";
  final String contactUs = "/admin/contact-us";
  final String updateLocation = "/users/profile";
  ////in app Url/////////////
  final String homeSlider = "/promotions";
  final String lastOrder = "/orders/last-order";

  // Notification
  final String notification = "/notifications";
  static String singleNotification(var notificationId) =>
      "/notifications/$notificationId/mark-as-read";

  /// Store Orders
  final String stores = "/stores";
  final String addToCart = "/carts";
  final String updateItemQuantity = "/carts/update-quantity";
  final String orderSummary = "/carts/addons-summary";
  final String updatetipAndPoints = "/carts/addons";
  final String storeCategories = "/categories";
  final String placeOrder = "/orders";
  final String deleteCart = "/carts/clear";
  static String storeProductById(var storeId) => "/stores/$storeId/products";
  static String singleProduct(var productId) => "/products/$productId";
  final String favorite = "/favorites/";

  // Gift card
  final String giftCardBalance = "/giftCards";
  final String giftCardsTransactions = "/giftCards";
  final String giftCardsRedeem = "/giftCardTransactions/redeem";
  final String giftCardsAdd = "/giftCards/add";

  // Reward
  final String rewardPoints = "/users/loyalty-points";
  final String rewardHistory = "/pointTransactions/my-history";
  static String loyeltyCardDetails(var orderId) => "/orders/$orderId";
  static String orderList(var orderType) => "/orders/$orderType";

  // Wallet
  final String walletBalance = "/wallets/balance";
  final String walletCardList = "/walletTransactions";
  static String walletHistory(var walletId) => "/walletTransactions/$walletId";
  final String walletAdd = "/wallets/add-money";

  // Favorite
  final String favoriteStoreList = "/favorites/stores";
  final String favoriteProductList = "/favorites/products";

  // Profile
  final String sendEmailSubscription = "/emailSubscriptions/subscribe";
  final String transectionHistory = "/orders/transactions/history";
  final String changePassword = "/auth/change-password";
  static String privacyPolicy(String title) => "/disclaimers/$title";
  static String deleteAccount(String userId) => "/users/$userId";
}

// Move this function outside the class
String _getDomain() {
  String liveServer = "http://10.10.7.11:5000";
  String localServer = "http://10.10.7.11:5000";
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
  String liveSocket = "http://10.10.7.11:5000";
  String localSocket = "http://10.10.7.11:5000";
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
