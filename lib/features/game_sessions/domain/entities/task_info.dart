import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TaskInfo {
  final String name;
  final String description;
  final int duration;
  final String? photoUrl;
  final TaskType type;
  final PollTaskAnswerType? pollAnswerType;
  final int? pollFixedDuration;
  final int? pollDynamicDuration;

  const TaskInfo(
      {required this.name,
      required this.description,
      required this.duration,
      this.photoUrl,
      required this.type,
      this.pollAnswerType,
      this.pollFixedDuration,
      this.pollDynamicDuration});
}
