import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TaskModel extends Task{
  
  const TaskModel({
    required super.name,
    required super.description,
    super.imageId,
    required super.duration,
    required super.type});

    factory TaskModel.fromJson(Map<String, dynamic> map) {
      return TaskModel(
        name: map['name'],
        description: map['description'],
        imageId: map['imageId'] ?? "",
        duration: map['duration'],
        type: map['type']
      );
    }

}