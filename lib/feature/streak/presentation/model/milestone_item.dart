import 'package:spendlock/feature/streak/presentation/model/milestone_card_state.dart';

class MilestoneItem {
  const MilestoneItem({
    required this.id,
    required this.title,
    required this.state,
    this.progress = 0,
  });

  final String id;
  final String title;
  final MilestoneCardState state;

  /// Only used when [state] is [MilestoneCardState.inProgress] (0–1).
  final double progress;

  MilestoneItem copyWith({
    String? id,
    String? title,
    MilestoneCardState? state,
    double? progress,
  }) {
    return MilestoneItem(
      id: id ?? this.id,
      title: title ?? this.title,
      state: state ?? this.state,
      progress: progress ?? this.progress,
    );
  }
}
