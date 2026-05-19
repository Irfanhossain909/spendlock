import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/route/app_routes_file.dart';
import 'package:spendlock/core/route/bindings/app_binding.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/theme/app_theme.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String _getInitialRoute() {
    final storage = GetStorageServices.instance;
    if (storage.getToken().isNotEmpty || storage.getIsGuest()) {
      if (storage.getSetupDone()) {
        return AppRoutes.instance.navigationScreen;
      }
      return AppRoutes.instance.setGoalScreen;
    }
    if (storage.getOnboardingDone()) {
      return AppRoutes.instance.loginScreen;
    }
    return AppRoutes.instance.splashScreen;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        initialBinding: AppBinding(),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'SpendLock',
        theme: AppTheme.lightTheme,
        getPages: appRootRoutesFile,
        // initialRoute: AppRoutes.instance.lockScreen,
        initialRoute: _getInitialRoute(),
      ),
    );
  }
}
