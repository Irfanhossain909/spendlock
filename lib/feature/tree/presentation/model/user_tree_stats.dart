class UserTreeStats {
  const UserTreeStats({
    required this.currentStreakDays,
    required this.weeklyGoalProgress,
    required this.weeklyGoalTotal,
    required this.monthlySaved,
    required this.totalSaved,
  });

  final int currentStreakDays;
  final int weeklyGoalProgress;
  final int weeklyGoalTotal;
  final double monthlySaved;
  final double totalSaved;
}
