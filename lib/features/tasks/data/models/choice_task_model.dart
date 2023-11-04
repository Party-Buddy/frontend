import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class ChoiceTaskModel extends TaskModel {
  final Set<ChoiceTaskOption>? options;

  const ChoiceTaskModel(
      {super.id,
      super.name,
      super.description,
      super.imageUri,
      super.duration,
      super.createdAt,
      super.updatedAt,
      this.options})
      : super(type: TaskType.choice);

  // JSON

  factory ChoiceTaskModel.fromJson(Map<String, dynamic> map) {
    return ChoiceTaskModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageId'],
        duration: map['duration'],
        updatedAt: map['updatedAt'],
        createdAt: map['createdAt'],
        options: map['options']);
  }

  // Domain

  @override
  Task toEntity() {
    return ChoiceTask(
        id: id,
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        duration: duration ?? 0,
        createdAt: createdAt,
        updatedAt: updatedAt,
        options: options ?? {});
  }

  factory ChoiceTaskModel.fromEntity(ChoiceTask task) {
    return ChoiceTaskModel(
        id: task.id,
        name: task.name,
        description: task.description,
        imageUri: task.imageUri,
        duration: task.duration,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        options: task.options);
  }

  // Storage

  Insertable<LocalChoiceTaskOption> toBinding({ChoiceTaskOption? option}) {
    return ChoiceTaskOptionsCompanion(
        baseTaskId: id != null ? Value(id!) : const Value.absent(),
        answer:
            option != null ? Value(option.alternative) : const Value.absent(),
        correct: option != null ? Value(option.correct) : const Value.absent());
  }

  factory ChoiceTaskModel.fromTables(
      LocalBaseTask baseTask, List<ChoiceTaskOption> options) {
    return ChoiceTaskModel(
        id: baseTask.id,
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        options: Set.from(options));
  }
}
