import 'package:party_games_app/features/tasks/domain/entities/task.dart';

enum PollTaskAnswerType { image, text }

class PollTask extends Task {
  final PollTaskAnswerType pollAnswerType;
  final int pollFixedDuration;
  final int pollDynamicDuration;

  const PollTask({
    super.id,
    required super.name,
    required super.description,
    super.imageUri,
    required super.duration,
    super.createdAt,
    super.updatedAt,
    required this.pollAnswerType,
    required this.pollFixedDuration,
    required this.pollDynamicDuration,
  }) : super(type: TaskType.poll);

  factory PollTask.fromOtherTask(
      Task baseTask, PollTaskAnswerType pollAnswerType,
      {int pollFixedDuration = 0, int pollDynamicDuration = 0}) {
    return PollTask(
        id: baseTask.id,
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        pollAnswerType: pollAnswerType,
        pollFixedDuration: pollFixedDuration,
        pollDynamicDuration: pollDynamicDuration);
  }

  @override
  Task copyWith(
      {int? id,
      String? name,
      String? description,
      String? imageUri,
      int? duration,
      TaskType? type,
      DateTime? createdAt,
      DateTime? updatedAt,
      PollTaskAnswerType? pollAnswerType,
      int? pollFixedDuration,
      int? pollDynamicDuration}) {
    return PollTask(
        id: id ?? super.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        duration: duration ?? super.duration,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt,
        pollAnswerType: pollAnswerType ?? this.pollAnswerType,
        pollFixedDuration: pollFixedDuration ?? this.pollFixedDuration,
        pollDynamicDuration: pollDynamicDuration ?? this.pollDynamicDuration);
  }
}
