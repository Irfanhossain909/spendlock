import 'package:dio/dio.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/service/api_service/app_in_put_unfocused.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/service/api_service/non_auth_api.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';

class AuthRepository {
  NonAuthApi nonAuthApi = NonAuthApi();
  AuthRepository._();

  static final AuthRepository _instance = AuthRepository._();
  static AuthRepository get instance => _instance;
  GetStorageServices storageServices = GetStorageServices.instance;
  // Future<dynamic> googleAuth({required String idToken}) async {
  //   try {
  //     // Keyboard / input focus remove
  //     appInPutUnfocused();

  //     // Google auth API call
  //     final response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.googleAuth,
  //       data: {"idToken": idToken},
  //     );

  //     // Check API success
  //     if (response.statusCode == 200 &&
  //         response.data != null &&
  //         response.data["data"] != null) {
  //       final data = response.data["data"];

  //       // -------------------------
  //       // Extract required values
  //       // -------------------------
  //       String accessToken = data["accessToken"] ?? "";
  //       bool isFirstTimeUser = data["usesubscriptionrId"] ?? false;
  //       String subscription = data["subscription"] ?? "";

  //       if (accessToken.isNotEmpty) {
  //         storageServices.setToken(accessToken);
  //       }

  //       AppPrint.apiResponse(accessToken, title: "Access Token Saved");

  //       // -------------------------
  //       // User first time logic
  //       // -------------------------
  //       if (!isFirstTimeUser) {
  //         // If subscription active
  //         if (subscription.isNotEmpty && subscription == "active") {
  //           AppPrint.apiResponse(subscription, title: "Active Subscription");
  //           return subscription; // go to premium flow
  //         } else {
  //           return true; // go to subscription screen
  //         }
  //       }

  //       // -------------------------
  //       // Old user → direct home
  //       // -------------------------

  //       return true;
  //     }

  //     // API response invalid
  //     AppPrint.apiResponse("Access Token not found!");
  //     return false;
  //   }
  //   // -------------------------
  //   // API Error Handling
  //   // -------------------------
  //   on DioException catch (error) {
  //     AppSnackBar.error(
  //       error.response?.data["message"] ?? "Something went wrong",
  //     );
  //     return false;
  //   }
  //   // -------------------------
  //   // Unknown error
  //   // -------------------------
  //   catch (e) {
  //     errorLog("googleAuth", e);
  //     return false;
  // }
  // }

  Future<bool> login({
    required String email,
    required String password,
    String authProvider = "local",
  }) async {
    try {
      Map<String, String> body = {
        "email": email,
        "password": password,
        "auth_provider": authProvider,
      };
      appInPutUnfocused();
      var response = await nonAuthApi.sendRequest.post(
        AppApiEndPoint.instance.login,
        data: body,
      );
      // AppLogger.api(response.data["data"]["accessToken"], title: "Store Token");
      if (response.data["success"] == true) {
        String accessToken = response.data["data"]["accessToken"];
        storageServices.setToken(accessToken);
        AppLogger.log("Store Token: ${storageServices.getToken()}");
        return true;
      } else {
        // Handle the error if the response or data is null
        AppLogger.error("Error: Access Token not found!");
      }

      return false;
    } on DioException catch (error) {
      if (error.response?.data["message"].runtimeType != null) {
        AppSnackBar.error(
          error.response?.data["message"] ?? "Something went wrong",
        );
      }
      return false;
    } catch (e) {
      AppLogger.error(e.toString());
      return false;
    }
  }

  // Future<bool> signUp({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     Map<String, String> body = {
  //       "name": name,
  //       "email": email,
  //       "password": password,
  //     };

  //     appInPutUnfocused();

  //     var response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.signUp,
  //       data: body,
  //     );

  //     AppLogger.api(response.toString());

  //     if (response.data["success"] == true) {
  //       appInPutUnfocused();
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on DioException catch (error) {
  //     appInPutUnfocused();

  //     String errorMessage = "Something went wrong";

  //     if (error.response != null && error.response?.data != null) {
  //       var responseData = error.response?.data;

  //       // Check different error message formats
  //       if (responseData is Map) {
  //         // Check for errorMessages array
  //         if (responseData["errorMessages"] != null &&
  //             responseData["errorMessages"] is List &&
  //             responseData["errorMessages"].isNotEmpty) {
  //           var firstError = responseData["errorMessages"][0];
  //           errorMessage = firstError is Map
  //               ? (firstError["message"] ?? firstError.toString())
  //               : firstError.toString();
  //         }
  //         // Check for direct message field
  //         else if (responseData["message"] != null) {
  //           errorMessage = responseData["message"].toString();
  //         }
  //         // Check for error field
  //         else if (responseData["error"] != null) {
  //           errorMessage = responseData["error"].toString();
  //         }
  //       } else if (responseData is String) {
  //         errorMessage = responseData;
  //       }

  //       Get.snackbar("Error", errorMessage);
  //       AppLogger.error(
  //         "SignUp DioException [${error.response?.statusCode}]: $errorMessage",
  //       );
  //     } else {
  //       // Network error or other issues
  //       errorMessage = "Network error. Please check your connection.";
  //       Get.snackbar("Error", errorMessage);
  //       AppLogger.error("SignUp DioException: ${error.message}");
  //     }

  //     return false;
  //   } catch (e) {
  //     appInPutUnfocused();
  //     AppLogger.error(e.toString());
  //     Get.snackbar("Error", "An unexpected error occurred");
  //     return false;
  //   }
  // }

  // Future<bool> emailVerify({required String email, required int otp}) async {
  //   Map<String, dynamic> body = {"email": email, "oneTimeCode": otp};
  //   try {
  //     var response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.verifyEmailOtp,
  //       data: body,
  //     );
  //     if (response.data["success"] == true) {
  //       String accessToken = response.data["data"];
  //       storageServices.setToken(accessToken);
  //       return true;
  //     } else {
  //       AppLogger.api("Error: Email Verification Failed!");
  //     }

  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  //   return false;
  // }

  // Future<bool> phoneVerify({required String phone, required int otp}) async {
  //   Map<String, dynamic> body = {"phone": phone, "oneTimeCode": otp};
  //   try {
  //     var response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.verifyPhoneOtp,
  //       data: body,
  //     );

  //     if (response.data["success"] == true) {
  //       String accessToken = response.data["data"]["accessToken"];
  //       storageServices.setToken(accessToken);
  //       return true;
  //     } else {
  //       AppLogger.api("Error: Phone Verification Failed!");
  //     }

  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  //   return false;
  // }

  // Future<bool> forgetPassword({required String email}) async {
  //   try {
  //     final response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.forgotPassword,
  //       data: {"email": email},
  //     );
  //     if (response.data["success"] == true) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on DioException catch (error) {
  //     if (error.response?.data["message"].runtimeType != Null) {
  //       Get.snackbar("Error", error.response?.data["message"]);
  //       return false;
  //     }
  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  //   return false;
  // }

  // Future<dynamic> forgetOtpVerify({
  //   required String phone,
  //   required String otp,
  // }) async {
  //   Map<String, dynamic> body = {"email": phone, "oneTimeCode": otp};
  //   try {
  //     var response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.verifyOtp,
  //       data: body,
  //     );
  //     if (response.statusCode == 200 && response.data["data"] != null) {
  //       return response.data["data"];
  //     } else if (response.statusCode == 400) {
  //       Get.snackbar("Error", response.data["message"]);
  //     } else {
  //       AppLogger.api("Error: Access Token not found!");
  //     }

  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  //   return false;
  // }

  // Future<bool> resendEmailOtp({required String email}) async {
  //   Map<String, String> body = {"email": email};
  //   try {
  //     final response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.resendEmailOtp,
  //       data: body,
  //     );
  //     AppLogger.api(response.data.toString(), title: "Resend OTP");
  //     if (response.data["success"] == true) {
  //       return true;
  //     }
  //   } on DioException catch (error) {
  //     if (error.response?.data["message"].runtimeType != Null) {
  //       Get.snackbar("Error", error.response?.data["message"]);
  //       return false;
  //     }
  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  //   return false;
  // }

  // Future<bool> resendPhoneOtp({required String phone}) async {
  //   Map<String, String> body = {"phone": phone};
  //   try {
  //     final response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.resendPhoneOtp,
  //       data: body,
  //     );
  //     AppLogger.api(response.data.toString(), title: "Resend OTP");
  //     if (response.data["success"] == true) {
  //       return true;
  //     }
  //   } on DioException catch (error) {
  //     if (error.response?.data["message"].runtimeType != Null) {
  //       Get.snackbar("Error", error.response?.data["message"]);
  //       return false;
  //     }
  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  //   return false;
  // }

  // Future<bool?> updateLocation({
  //   required String address,
  //   required double latitude,
  //   required double longitude,
  //   required String phone,
  //   required bool isOnboard,
  // }) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "address": address,
  //       "latitude": latitude,
  //       "longitude": longitude,
  //       "phone": phone,
  //       "isOnboard": isOnboard,
  //     };
  //     var response = await ApiServices.instance.apiPatchServices(
  //       url: AppApiEndPoint.instance.updateLocation,
  //       body: body,
  //     );
  //     if (response["success"] == true) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on DioException catch (error) {
  //     if (error.response?.data["message"].runtimeType != Null) {
  //       Get.snackbar("Error", error.response?.data["message"]);
  //       return false;
  //     }
  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  //   return false;
  // }

  // Future<bool> resetPassword({
  //   required String newPassword,
  //   required String confirmPassword,
  //   required String resetToken,
  // }) async {
  //   try {
  //     appInPutUnfocused();
  //     Map body = {
  //       "newPassword": newPassword,
  //       "confirmPassword": confirmPassword,
  //     };
  //     var response = await nonAuthApi.sendRequest.post(
  //       AppApiEndPoint.instance.resetPassword,
  //       data: body,
  //       options: Options(
  //         receiveTimeout: const Duration(minutes: 2),
  //         sendTimeout: const Duration(minutes: 2),
  //         headers: {"Accept": "application/json", "Authorization": resetToken},
  //       ),
  //     );

  //     if (response.data["success"] == true) {
  //       AppLogger.api("confirm password repository response :: $response");
  //       return true;
  //     }
  //     return false;
  //   } on DioException catch (error) {
  //     if (error.response?.data["message"].runtimeType != Null) {
  //       Get.snackbar("Error", error.response?.data["message"]);
  //       return false;
  //     }
  //     return false;
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //     return false;
  //   }
  // }
}
