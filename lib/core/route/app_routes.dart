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

  // Setup
  final String setGoalScreen = '/set-goal-screen';
  final String setChallengeScreen = '/set-challenge-screen';
  final String enableNotificationScreen = '/enable-notification-screen';
  final String connectBankScreen = '/connect-bank-screen';
  final String budgetScreen = '/budget-screen';

  // Main tabs
  final String homeScreen = '/home-screen';
  final String rulesScreen = '/rules-screen';
  final String treeScreen = '/tree-screen';
  final String streakScreen = '/streak-screen';
  final String profileScreen = '/profile-screen';
}
