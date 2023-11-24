import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class PollTaskModel extends TaskModel {
  final PollTaskAnswerType? pollAnswerType;
  final int? pollFixedDuration;
  final int? pollDynamicDuration;

  const PollTaskModel(
      {super.id,
      super.name,
      super.description,
      super.imageUri,
      super.duration,
      super.createdAt,
      super.updatedAt,
      this.pollAnswerType,
      this.pollFixedDuration,
      this.pollDynamicDuration})
      : super(type: TaskType.poll);

  // JSON

  factory PollTaskModel.fromJson(Map<String, dynamic> map) {
    return PollTaskModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageId'] ?? "",
        duration: map['duration'],
        updatedAt: map['updatedAt'],
        createdAt: map['createdAt'],
        pollAnswerType: PollTaskAnswerType.values.firstWhere(
            (element) => element.toString() == map['pollAnswerType']));
        // TODO poll duration
  }

  @override
  Map<String, dynamic> toJson() {
    var json = baseToJson();
    json.addAll({
      'type': pollAnswerType == PollTaskAnswerType.image ? 'photo' : 'text',
      'poll-duration': pollFixedDuration != 0
          ? {'kind': 'fixed', 'secs': pollFixedDuration ?? 0}
          : {'kind': 'dynamic', 'secs': pollDynamicDuration ?? 0},
    });
    return json;
  }

  // Domain

  @override
  Task toEntity() {
    return PollTask(
        id: id,
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        duration: duration ?? 0,
        createdAt: createdAt,
        updatedAt: updatedAt,
        pollAnswerType: pollAnswerType ?? PollTaskAnswerType.text,
        pollFixedDuration: pollFixedDuration ?? 0,
        pollDynamicDuration: pollDynamicDuration ?? 0);
  }

  factory PollTaskModel.fromEntity(PollTask task) {
    return PollTaskModel(
        id: task.id,
        name: task.name,
        description: task.description,
        imageUri: task.imageUri,
        duration: task.duration,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        pollAnswerType: task.pollAnswerType,
        pollFixedDuration: task.pollFixedDuration,
        pollDynamicDuration: task.pollDynamicDuration);
  }

  // Storage

  factory PollTaskModel.fromTables(
      LocalBaseTask baseTask, LocalPollTask pollTask) {
    return PollTaskModel(
        id: baseTask.id,
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        pollAnswerType: PollTaskAnswerType.values.firstWhere(
            (element) => element.toString() == pollTask.pollAnswerType),
        pollFixedDuration: pollTask.pollFixedDuration,
        pollDynamicDuration: pollTask.pollDynamicDuration);
  }

  Insertable<LocalPollTask> toInsertable({int? baseId}) {
    return PollTasksCompanion(
        baseTaskId: baseId != null
            ? Value(baseId)
            : (id != null ? Value(id!) : const Value.absent()),
        pollAnswerType: pollAnswerType != null
            ? Value(pollAnswerType!.toString())
            : const Value.absent(),
        pollFixedDuration:
            pollFixedDuration != null ? const Value(0) : const Value.absent(),
        pollDynamicDuration: pollDynamicDuration != null
            ? const Value(0)
            : const Value.absent());
  }
}
