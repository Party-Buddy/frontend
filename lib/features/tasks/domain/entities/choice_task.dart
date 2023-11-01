import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class ChoiceTaskOption {
  final String alternative;
  final bool correct;
  
  const ChoiceTaskOption({required this.alternative, required this.correct});
}

class ChoiceTask extends Task{
  final String answer;
  final List<ChoiceTaskOption> options;
  
  const ChoiceTask({
    required super.id,
    required super.name,
    required super.description,
    super.imageId,
    required super.duration,

    required this.answer,
    required this.options
    }): super(type: TaskTypes.choice);
}
