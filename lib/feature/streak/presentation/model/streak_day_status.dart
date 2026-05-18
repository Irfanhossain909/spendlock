/// Calendar cell styling for a day in the streak month grid.
enum StreakDayStatus {
  /// Completed successfully (teal cell).
  success,

  /// Streak broken (red cell).
  broken,

  /// Coin was used (orange cell).
  coinUsed,

  /// In list but neutral / no streak mark (plain emphasis).
  neutral,
}
