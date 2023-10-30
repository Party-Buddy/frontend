import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class CheckedTextTask extends Task{
  final String answer;

  const CheckedTextTask({
    required super.name,
    required super.description,
    super.imageId,
    required super.duration,
    
    required this.answer
    }) : super(type: TaskTypes.checkedText); 
}
