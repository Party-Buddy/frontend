import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/checked_text_task_model.dart';
import 'package:party_games_app/features/tasks/data/models/choice_task_model.dart';
import 'package:party_games_app/features/tasks/data/models/poll_task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

abstract class TaskModel {
  final String? name;
  final String? description;
  final String? imageUri;
  final int? duration;
  final TaskType? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaskModel(
      {this.name,
      this.description,
      this.imageUri,
      this.duration,
      this.type,
      this.createdAt,
      this.updatedAt});

  // Domain

  factory TaskModel.fromEntity(Task task) {
    if (task is OwnedTask) {
      return OwnedTaskModel.fromEntity(task);
    } else if (task is PublishedTask) {
      return PublishedTaskModel.fromEntity(task);
    } else {
      throw Error();
    }
  }

  Task toEntity();

  Map<String, dynamic> baseToJson() {
    var json = <String, dynamic>{
      'name': name ?? '',
      'description': description ?? '',
      'duration': <String, dynamic>{'kind': 'fixed', 'secs': duration ?? 0}
    };
    return json;
  }

  Map<String, dynamic> toJson();

  Insertable<LocalBaseTask> baseToInsertable();
}

abstract class OwnedTaskModel extends TaskModel {
  final int? id;
  final String? sourceId;

  const OwnedTaskModel(
      {this.id,
      this.sourceId,
      super.name,
      super.description,
      super.imageUri,
      super.duration,
      super.type,
      super.createdAt,
      super.updatedAt});

  factory OwnedTaskModel.fromEntity(OwnedTask task) {
    if (task is OwnedCheckedTextTask) {
      return OwnedCheckedTextTaskModel.fromEntity(task);
    } else if (task is OwnedChoiceTask) {
      return OwnedChoiceTaskModel.fromEntity(task);
    } else if (task is OwnedPollTask) {
      return OwnedPollTaskModel.fromEntity(task);
    } else {
      throw Error();
    }
  }

  @override
  OwnedTask toEntity();

  @override
  Insertable<LocalBaseTask> baseToInsertable() {
    return BaseTasksCompanion(
        id: const Value.absent(),
        name: name != null ? Value(name!) : const Value.absent(),
        description:
            description != null ? Value(description!) : const Value.absent(),
        imageUri: imageUri != null ? Value(imageUri!) : const Value.absent(),
        duration: duration != null ? Value(duration!) : const Value.absent(),
        type: duration != null ? Value(type!.toString()) : const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        sourceId: sourceId != null ? Value(sourceId!) : const Value.absent());
  }

  Insertable<LocalBaseTask> baseToUpdatable() {
    return BaseTasksCompanion(
        id: id != null ? Value(id!) : const Value.absent(),
        name: name != null ? Value(name!) : const Value.absent(),
        description:
            description != null ? Value(description!) : const Value.absent(),
        imageUri: imageUri != null ? Value(imageUri!) : const Value.absent(),
        duration: duration != null ? Value(duration!) : const Value.absent(),
        type: duration != null ? Value(type!.toString()) : const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        sourceId: const Value.absent());
  }

  Insertable<LocalBaseTask> baseToRemovable() {
    return BaseTasksCompanion(
        id: id != null ? Value(id!) : const Value.absent());
  }
}

abstract class PublishedTaskModel extends TaskModel {
  final String? id;

  const PublishedTaskModel(
      {this.id,
      super.name,
      super.description,
      super.imageUri,
      super.duration,
      super.type,
      super.createdAt,
      super.updatedAt});

  factory PublishedTaskModel.fromEntity(PublishedTask task) {
    if (task is PublishedCheckedTextTask) {
      return PublishedCheckedTextTaskModel.fromEntity(task);
    } else if (task is PublishedChoiceTask) {
      return PublishedChoiceTaskModel.fromEntity(task);
    } else if (task is PublishedPollTask) {
      return PublishedPollTaskModel.fromEntity(task);
    } else {
      throw Error();
    }
  }

  @override
  PublishedTask toEntity();

  factory PublishedTaskModel.fromJson(Map<String, dynamic> map) {
    TaskType type = TaskType.values.firstWhere(
        (element) => element.toString() == 'TaskTypes.${map['type']}');
    switch (type) {
      case TaskType.checkedText:
        return PublishedCheckedTextTaskModel.fromJson(map);
      case TaskType.choice:
        return PublishedChoiceTaskModel.fromJson(map);
      case TaskType.poll:
        return PublishedPollTaskModel.fromJson(map);
      default:
        throw ArgumentError('Invalid type');
    }
  }

  @override
  Insertable<LocalBaseTask> baseToInsertable() {
    return BaseTasksCompanion(
        id: const Value.absent(),
        name: name != null ? Value(name!) : const Value.absent(),
        description:
            description != null ? Value(description!) : const Value.absent(),
        imageUri: imageUri != null ? Value(imageUri!) : const Value.absent(),
        duration: duration != null ? Value(duration!) : const Value.absent(),
        type: duration != null ? Value(type!.toString()) : const Value.absent(),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        sourceId: id != null ? Value(id!) : const Value.absent());
  }
}
