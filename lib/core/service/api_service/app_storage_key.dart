class AppStorageKey {
  AppStorageKey._privateConstructor();
  static final AppStorageKey _instance = AppStorageKey._privateConstructor();
  static AppStorageKey get instance => _instance;

  final String token = 'token';
  final String isGuest = 'is_guest';
  final String name = 'name';
  final String onboardingDone = 'onboarding_done';
  final String setupDone = 'setup_done';
}
