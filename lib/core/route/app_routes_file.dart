import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/route/bindings/app_binding.dart';
import 'package:spendlock/core/route/bindings/onboarding_binding.dart';
import 'package:spendlock/core/route/bindings/auth_binding.dart';
import 'package:spendlock/core/route/bindings/setup_binding.dart';
import 'package:spendlock/core/route/bindings/splash_binding.dart';
import 'package:spendlock/feature/auth/presentation/ui/forgot_password_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/login_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/register_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/reset_password_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/verify_email_screen.dart';
import 'package:spendlock/feature/navigation/presentation/ui/navigation_screen.dart';
import 'package:spendlock/feature/onboarding/presentation/ui/onboarding_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/budget_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/connect_bank_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/enable_notification_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/set_challenge_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/set_goal_screen.dart';
import 'package:spendlock/feature/splash/presentation/ui/splash_screen.dart';

List<GetPage<dynamic>> appRootRoutesFile = <GetPage<dynamic>>[
  GetPage(
    name: AppRoutes.instance.splashScreen,
    binding: SplashBinding(),
    page: SplashScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.onboardingScreen,
    binding: OnboardingBinding(),
    page: OnboardingScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.navigationScreen,
    binding: AppBinding(),
    page: NavigationScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.loginScreen,
    binding: AuthBinding(),
    page: LoginScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.registerScreen,
    binding: AuthBinding(),
    page: RegisterScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.verifyEmailScreen,
    binding: AuthBinding(),
    page: VerifyEmailScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.forgotPasswordScreen,
    binding: AuthBinding(),
    page: ForgotPasswordScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.resetPasswordScreen,
    binding: AuthBinding(),
    page: ResetPasswordScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.setGoalScreen,
    binding: SetupBinding(),
    page: SetGoalScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.setChallengeScreen,
    binding: SetupBinding(),
    page: SetChallengeScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.enableNotificationScreen,
    binding: SetupBinding(),
    page: EnableNotificationScreen.new,
  ),
  GetPage(name: AppRoutes.instance.connectBankScreen, page: ConnectBankScreen.new),
  GetPage(
    name: AppRoutes.instance.budgetScreen,
    binding: SetupBinding(),
    page: BudgetScreen.new,
  ),
];
