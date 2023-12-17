import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

mixin CheckedTextTaskMixin {
  late final String? answer;
  CheckedTextTasksCompanion mixinToInsertable() {
    return CheckedTextTasksCompanion(
        answer: answer != null ? Value(answer!) : const Value.absent());
  }
}

class OwnedCheckedTextTaskModel extends OwnedTaskModel
    with CheckedTextTaskMixin {
  OwnedCheckedTextTaskModel(
      {super.id,
      super.name,
      super.description,
      super.imageUri,
      super.duration,
      super.createdAt,
      super.updatedAt,
      super.sourceId,
      String? answer})
      : super(type: TaskType.checkedText) {
    this.answer = answer;
  }

  // JSON

  @override
  Map<String, dynamic> toJson() {
    var json = baseToJson();
    json.addAll(<String, dynamic>{
      'type': 'checked-text',
      'answer': answer?.toUpperCase(),
    });
    return json;
  }

  // Domain

  @override
  OwnedTask toEntity() {
    return OwnedCheckedTextTask(
        id: id,
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        duration: duration ?? 0,
        createdAt: createdAt,
        updatedAt: updatedAt,
        sourceId: sourceId,
        answer: answer ?? "");
  }

  factory OwnedCheckedTextTaskModel.fromEntity(OwnedCheckedTextTask task) {
    return OwnedCheckedTextTaskModel(
        id: task.id,
        name: task.name,
        description: task.description,
        imageUri: task.imageUri,
        duration: task.duration,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        sourceId: task.sourceId,
        answer: task.answer);
  }

  // Storage

  factory OwnedCheckedTextTaskModel.fromTables(
      LocalBaseTask baseTask, LocalCheckedTextTask checkedTextTask) {
    return OwnedCheckedTextTaskModel(
        id: baseTask.id,
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        sourceId: baseTask.sourceId,
        answer: checkedTextTask.answer);
  }

  Insertable<LocalCheckedTextTask> toInsertable({int? baseId}) {
    return mixinToInsertable().copyWith(
        baseTaskId: baseId != null
            ? Value(baseId)
            : (id != null ? Value(id!) : const Value.absent()));
  }
}

class PublishedCheckedTextTaskModel extends PublishedTaskModel
    with CheckedTextTaskMixin {
  PublishedCheckedTextTaskModel(
      {super.id,
      super.name,
      super.description,
      super.imageUri,
      super.duration,
      super.createdAt,
      super.updatedAt,
      String? answer})
      : super(type: TaskType.checkedText) {
    this.answer = answer;
  }

  OwnedCheckedTextTaskModel makeOwned() {
    return OwnedCheckedTextTaskModel(
      name: name,
      description: description,
      imageUri: imageUri,
      duration: duration,
      createdAt: createdAt,
      updatedAt: updatedAt,
      sourceId: id,
      answer: answer,
    );
  }

  // JSON

  factory PublishedCheckedTextTaskModel.fromJson(Map<String, dynamic> map) {
    return PublishedCheckedTextTaskModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageId'],
        duration: map['duration'],
        updatedAt: map['updatedAt'],
        createdAt: map['createdAt'],
        answer: map['answer']);
  }

  @override
  Map<String, dynamic> toJson() {
    var json = baseToJson();
    json.addAll(<String, dynamic>{
      'type': 'checked-text',
      'answer': answer,
    });
    return json;
  }

  // Domain

  @override
  PublishedTask toEntity() {
    return PublishedCheckedTextTask(
        id: id,
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        duration: duration ?? 0,
        createdAt: createdAt,
        updatedAt: updatedAt,
        answer: answer ?? "");
  }

  factory PublishedCheckedTextTaskModel.fromEntity(
      PublishedCheckedTextTask task) {
    return PublishedCheckedTextTaskModel(
        id: task.id,
        name: task.name,
        description: task.description,
        imageUri: task.imageUri,
        duration: task.duration,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        answer: task.answer);
  }

  Insertable<LocalCheckedTextTask> toInsertable({required int baseId}) {
    return mixinToInsertable().copyWith(baseTaskId: Value(baseId));
  }
}
