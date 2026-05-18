class AppStorageKey {
  AppStorageKey._privateConstructor();
  static final AppStorageKey _instance = AppStorageKey._privateConstructor();
  static AppStorageKey get instance => _instance;

  final String token = 'token';
  final String isGuest = 'is_guest';
  final String name = 'name';
  final String email = 'email';
  final String selectedGoal = 'selected_goal';
  final String selectedChallenges = 'selected_challenges';
  final String monthlyBudget = 'monthly_budget';
  final String onboardingDone = 'onboarding_done';
  final String setupDone = 'setup_done';
}
