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

  factory CheckedTextTask.fromOtherTask(Task baseTask, String answer) {
      return CheckedTextTask(
        id: baseTask.id,
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        answer: answer);
    }

  @override
  Task copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUri,
    int? duration,
    TaskType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? answer
  }) {
    return CheckedTextTask(
      id: id ?? super.id,
      name: name ?? super.name,
      description: description ?? super.description,
      imageUri: imageUri ?? super.imageUri,
      duration: duration ?? super.duration,
      createdAt: createdAt ?? super.createdAt,
      updatedAt: updatedAt ?? super.updatedAt,
      answer: answer ?? this.answer
    );
  }

}
