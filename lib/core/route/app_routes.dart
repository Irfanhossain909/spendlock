class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;

  final String splashScreen = '/splash-screen';
  final String onboardingScreen = '/onboarding-screen';
  final String navigationScreen = '/navigation-screen';

  // Auth
  final String loginScreen = '/login-screen';
  final String registerScreen = '/register-screen';
  final String verifyEmailScreen = '/verify-email-screen';
  final String forgotPasswordScreen = '/forgot-password-screen';
  final String resetPasswordScreen = '/reset-password-screen';

  // Setup
  final String setGoalScreen = '/set-goal-screen';
  final String setChallengeScreen = '/set-challenge-screen';
  final String enableNotificationScreen = '/enable-notification-screen';
  final String connectBankScreen = '/connect-bank-screen';
  final String budgetScreen = '/budget-screen';

  // Notification
  final String notificationScreen = '/notification-screen';

  // Lock Screen
  final String lockScreen = '/lock-screen';

  // Coin
  final String myCoinScreen = '/my-coin-screen';
  final String buyCoinScreen = '/buy-coin-screen';

  // Main tabs
  final String homeScreen = '/home-screen';
  final String rulesScreen = '/rules-screen';
  final String addRulsScreen = '/add-ruls-screen';
  final String setRulsContentScreen = '/set-ruls-content-screen';
  final String selectRuleAppsScreen = '/select-rule-apps-screen';
  final String treeScreen = '/tree-screen';
  final String streakScreen = '/streak-screen';
  final String profileScreen = '/profile-screen';
  final String personalDetailsScreen = '/personal-details-screen';
  final String changePasswordScreen = '/change-password-screen';
  final String connectAccountScreen = '/connect-account-screen';
  final String appUseScreen = '/app-use-screen';

  // Preference
  final String myPreferenceScreen = '/my-preference-screen';
  final String preferenceMotivationScreen = '/preference-motivation-screen';
  final String preferenceTriggersScreen = '/preference-triggers-screen';
  final String preferenceBudgetScreen = '/preference-budget-screen';
}
