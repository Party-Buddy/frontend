import 'package:floor/floor.dart';
import 'package:party_games_app/features/tasks/data/models/common/task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

@Entity(tableName: 'checked_text_task', primaryKeys: ['id'])
class CheckedTextTaskModel extends TaskModel{
  
  final String answer;

  const CheckedTextTaskModel({
    required super.id,
    required super.name,
    required super.description,
    super.imageId,
    required super.duration,
    required this.answer
  }) : super(type: TaskTypes.checkedText);

    factory CheckedTextTaskModel.fromJson(Map<String, dynamic> map) {
      return CheckedTextTaskModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageId: map['imageId'] ?? "",
        duration: map['duration'],
        answer: map['answer']
      );
    }

}