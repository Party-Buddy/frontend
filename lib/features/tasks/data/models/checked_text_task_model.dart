import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class CheckedTextTaskModel extends TaskModel {
  final String? answer;

  const CheckedTextTaskModel(
      {super.id,
      super.name,
      super.description,
      super.imageUri,
      super.duration,
      super.createdAt,
      super.updatedAt,
      this.answer})
      : super(type: TaskType.checkedText);

  // JSON

  factory CheckedTextTaskModel.fromJson(Map<String, dynamic> map) {
    return CheckedTextTaskModel(
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
  Task toEntity() {
    return CheckedTextTask(
        id: id,
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        duration: duration ?? 0,
        createdAt: createdAt,
        updatedAt: updatedAt,
        answer: answer ?? "");
  }

  factory CheckedTextTaskModel.fromEntity(CheckedTextTask task) {
    return CheckedTextTaskModel(
        id: task.id,
        name: task.name,
        description: task.description,
        imageUri: task.imageUri,
        duration: task.duration,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        answer: task.answer);
  }

  // Storage

  factory CheckedTextTaskModel.fromTables(
      LocalBaseTask baseTask, LocalCheckedTextTask checkedTextTask) {
    return CheckedTextTaskModel(
        id: baseTask.id,
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        answer: checkedTextTask.answer);
  }

  Insertable<LocalCheckedTextTask> toInsertable({int? baseId}) {
    return CheckedTextTasksCompanion(
        baseTaskId: baseId != null
            ? Value(baseId)
            : (id != null ? Value(id!) : Value.absent()),
        answer: answer != null ? Value(answer!) : const Value.absent());
  }
}
