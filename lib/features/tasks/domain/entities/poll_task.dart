import 'package:party_games_app/features/tasks/domain/entities/task.dart';

enum PollTaskAnswerType {image, text}

class PollTask extends Task{
  final PollTaskAnswerType pollAnswerType;
  
  const PollTask({
    required super.id,
    required super.name,
    required super.description,
    super.imageId,
    required super.duration,
    
    required this.pollAnswerType
    }): super(type: TaskTypes.poll);
}
