import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class OwnedChoiceTaskModel extends OwnedTaskModel {
  final Set<ChoiceTaskOption>? options;

  const OwnedChoiceTaskModel(
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

  @override
  Map<String, dynamic> toJson() {
    var json = baseToJson();
    json.addAll({
      'type': 'choice',
      'options': options?.map((option) => option.alternative).toList(),
      'answer-idx': options?.firstWhere((option) => option.correct)
    });
    return json;
  }

  // Domain

  @override
  OwnedTask toEntity() {
    return OwnedChoiceTask(
        id: id,
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        duration: duration ?? 0,
        createdAt: createdAt,
        updatedAt: updatedAt,
        options: options ?? {});
  }

  factory OwnedChoiceTaskModel.fromEntity(OwnedChoiceTask task) {
    return OwnedChoiceTaskModel(
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

  factory OwnedChoiceTaskModel.fromTables(
      LocalBaseTask baseTask, List<ChoiceTaskOption> options) {
    return OwnedChoiceTaskModel(
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

class PublishedChoiceTaskModel extends PublishedTaskModel {
  final Set<ChoiceTaskOption>? options;

  const PublishedChoiceTaskModel(
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

  factory PublishedChoiceTaskModel.fromJson(Map<String, dynamic> map) {
    return PublishedChoiceTaskModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageId'],
        duration: map['duration'],
        updatedAt: map['updatedAt'],
        createdAt: map['createdAt'],
        options: map['options']);
  }

  @override
  Map<String, dynamic> toJson() {
    var json = baseToJson();
    json.addAll({
      'type': 'choice',
      'options': options?.map((option) => option.alternative).toList(),
      'answer-idx': options?.firstWhere((option) => option.correct)
    });
    return json;
  }

  // Domain

  @override
  PublishedTask toEntity() {
    return PublishedChoiceTask(
        id: id,
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        duration: duration ?? 0,
        createdAt: createdAt,
        updatedAt: updatedAt,
        options: options ?? {});
  }

  factory PublishedChoiceTaskModel.fromEntity(PublishedChoiceTask task) {
    return PublishedChoiceTaskModel(
        id: task.id,
        name: task.name,
        description: task.description,
        imageUri: task.imageUri,
        duration: task.duration,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        options: task.options);
  }
}
