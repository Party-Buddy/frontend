import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class CheckedTextTask extends Task{
  final String answer;

  const CheckedTextTask({
    super.id,
    required super.name,
    required super.description,
    super.imageUri,
    required super.duration,
    super.createdAt,
    super.updatedAt,
    
    required this.answer
    }) : super(type: TaskType.checkedText); 
}
