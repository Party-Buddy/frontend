import 'package:party_games_app/features/tasks/data/models/common/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TaskModel extends Task{
  
  const TaskModel({
    required super.id,
    required super.name,
    required super.description,
    super.imageUri,
    required super.duration,
    required super.type});

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

}