import 'package:party_games_app/features/tasks/domain/entities/task.dart';

enum PollTaskAnswerType {image, text}

class PollTask extends Task{
  final PollTaskAnswerType pollAnswerType;
  
  const PollTask({
    super.id,
    required super.name,
    required super.description,
    super.imageUri,
    required super.duration,
    super.createdAt,
    super.updatedAt,
    
    required this.pollAnswerType
    }): super(type: TaskType.poll);
}
