import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/common/task.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class CheckedTextTaskModel extends TaskModel{
  
  final String answer;

  const CheckedTextTaskModel({
    required super.id,
    required super.name,
    required super.description,
    super.imageUri,
    required super.duration,
    required this.answer
  }) : super(type: TaskType.checkedText);

    factory CheckedTextTaskModel.fromJson(Map<String, dynamic> map) {
      return CheckedTextTaskModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageId'] ?? "",
        duration: map['duration'],
        answer: map['answer']
      );
    }

    static Task toEntity(CheckedTextTaskModel task) {
      return CheckedTextTask(
        id: task.id,
        name: task.name,
        description: task.description,
        imageUri: task.imageUri,
        duration: task.duration,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        answer: task.answer
      );
    }

}