import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/checked_text_task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';


class TaskModel {

  final int? id;
  final String? name;
  final String? description;
  final String? imageUri;
  final int? duration;
  final TaskType? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaskModel({
    this.id,
    this.name,
    this.description,
    this.imageUri,
    this.duration,
    this.type,
    this.createdAt,
    this.updatedAt
    });

  /*
  factory LocalBaseTaskModel.fromDataClass(DataClass task){
    if (task is LocalCheckedTextTask) {
      return CheckedTextTaskModel.fromDataClass(task);
    }
    else{
      throw Error();
    }
  }
  */

  factory TaskModel.fromEntity(Task task){
    if (task is CheckedTextTask) {
      return CheckedTextTaskModel.fromEntity(task);
    }
    else{
      throw Error();
    }
  }

  static Task toEntity(TaskModel task){
    if (task is CheckedTextTaskModel) {
      return task.toEntity();
    }
    else{
      throw Error();
    }
  }


  // Json

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    TaskType type = TaskType.values
      .firstWhere((element) => element.toString() == 'TaskTypes.${map['type']}');
    switch (type) {
      case TaskType.checkedText:
        return CheckedTextTaskModel.fromJson(map);
      default:
        throw ArgumentError('Invalid type');
    }
  }

  // Storage

  Insertable<LocalBaseTask> baseToInsertable(){
    return BaseTasksCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: name != null ? Value(name!) : const Value.absent(),
      description: description != null ? Value(description!) : const Value.absent(),
      imageUri: imageUri != null ? Value(imageUri!) : const Value.absent(),
      duration: duration != null ? Value(duration!) : const Value.absent(),
      type: duration != null ? Value(type!.toString()) : const Value.absent(),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now())
    );
  }
      
}