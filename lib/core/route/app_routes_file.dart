import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/route/bindings/app_binding.dart';
import 'package:spendlock/core/route/bindings/coin_binding.dart';
import 'package:spendlock/core/route/bindings/onboarding_binding.dart';
import 'package:spendlock/core/route/bindings/auth_binding.dart';
import 'package:spendlock/core/route/bindings/add_rules_binding.dart';
import 'package:spendlock/core/route/bindings/select_rule_apps_binding.dart';
import 'package:spendlock/core/route/bindings/set_rules_content_binding.dart';
import 'package:spendlock/core/route/bindings/setup_binding.dart';
import 'package:spendlock/core/route/bindings/splash_binding.dart';
import 'package:spendlock/feature/auth/presentation/ui/forgot_password_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/login_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/register_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/reset_password_screen.dart';
import 'package:spendlock/feature/auth/presentation/ui/verify_email_screen.dart';
import 'package:spendlock/feature/coin/presentation/ui/buy_coin_screen.dart';
import 'package:spendlock/feature/coin/presentation/ui/my_coin_screen.dart';
import 'package:spendlock/feature/lock_screen/presentation/ui/lock_screen.dart';
import 'package:spendlock/feature/navigation/presentation/ui/navigation_screen.dart';
import 'package:spendlock/feature/nofication/presentation/ui/notification_screen.dart';
import 'package:spendlock/feature/onboarding/presentation/ui/onboarding_screen.dart';
import 'package:spendlock/feature/profile/presentation/ui/connect_account_screen.dart';
import 'package:spendlock/feature/rules/presentation/ui/add_ruls_screen.dart';
import 'package:spendlock/feature/rules/presentation/ui/select_rule_apps_screen.dart';
import 'package:spendlock/feature/rules/presentation/ui/set_ruls_content_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/budget_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/connect_bank_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/enable_notification_screen.dart';
import 'package:spendlock/feature/setup/presentation/ui/set_challenge_screen.dart';
import 'package:spendlock/core/route/bindings/preference_binding.dart';
import 'package:spendlock/core/route/bindings/profile_binding.dart';
import 'package:spendlock/feature/preference/presentation/ui/my_preference_screen.dart';
import 'package:spendlock/feature/preference/presentation/ui/preference_budget_screen.dart';
import 'package:spendlock/feature/preference/presentation/ui/preference_motivation_screen.dart';
import 'package:spendlock/feature/preference/presentation/ui/preference_triggers_screen.dart';
import 'package:spendlock/feature/profile/presentation/ui/app_use_screen.dart';
import 'package:spendlock/feature/profile/presentation/ui/change_password_screen.dart';
import 'package:spendlock/feature/profile/presentation/ui/personal_details_screen.dart';
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
  GetPage(
    name: AppRoutes.instance.connectBankScreen,
    page: ConnectBankScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.budgetScreen,
    binding: SetupBinding(),
    page: BudgetScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.personalDetailsScreen,
    binding: ProfileBinding(),
    page: PersonalDetailsScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.changePasswordScreen,
    binding: ProfileBinding(),
    page: ChangePasswordScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.myPreferenceScreen,
    binding: PreferenceBinding(),
    page: MyPreferenceScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.preferenceMotivationScreen,
    binding: PreferenceBinding(),
    page: PreferenceMotivationScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.preferenceTriggersScreen,
    binding: PreferenceBinding(),
    page: PreferenceTriggersScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.preferenceBudgetScreen,
    binding: PreferenceBinding(),
    page: PreferenceBudgetScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.connectAccountScreen,
    binding: ProfileBinding(),
    page: ConnectAccountScreen.new,
  ),
  GetPage(name: AppRoutes.instance.appUseScreen, page: AppUseScreen.new),
  GetPage(
    name: AppRoutes.instance.addRulsScreen,
    page: AddRulsScreen.new,
    binding: AddRulesBinding(),
  ),
  GetPage(
    name: AppRoutes.instance.setRulsContentScreen,
    binding: SetRulesContentBinding(),
    page: SetRulsContentScreen.new,
  ),
  GetPage(
    name: AppRoutes.instance.selectRuleAppsScreen,
    binding: SelectRuleAppsBinding(),
    page: SelectRuleAppsScreen.new,
  ),

  GetPage(
    name: AppRoutes.instance.myCoinScreen,
    page: MyCoinScreen.new,
    binding: CoinBinding(),
  ),
  GetPage(
    name: AppRoutes.instance.buyCoinScreen,
    page: BuyCoinScreen.new,
    binding: CoinBinding(),
  ),
  GetPage(
    name: AppRoutes.instance.notificationScreen,
    page: NotificationScreen.new,
  ),
  GetPage(name: AppRoutes.instance.lockScreen, page: LockScreen.new),
];
