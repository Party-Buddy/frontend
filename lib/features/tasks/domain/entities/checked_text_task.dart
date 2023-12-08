import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class OwnedCheckedTextTask extends OwnedTask {
  final String answer;

  OwnedCheckedTextTask(
      {super.id,
      required super.name,
      required super.description,
      super.imageUri,
      required super.duration,
      super.createdAt,
      super.updatedAt,
      required this.answer})
      : super(type: TaskType.checkedText);

  factory OwnedCheckedTextTask.fromOtherTask(Task baseTask, String answer) {
    return OwnedCheckedTextTask(
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        answer: answer);
  }

  @override
  OwnedTask copyWith(
      {int? id,
      String? name,
      String? description,
      String? imageUri,
      int? duration,
      TaskType? type,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? answer}) {
    return OwnedCheckedTextTask(
        id: id ?? super.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        duration: duration ?? super.duration,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt,
        answer: answer ?? this.answer);
  }
}

class PublishedCheckedTextTask extends PublishedTask {
  final String answer;

  PublishedCheckedTextTask(
      {super.id,
      required super.name,
      required super.description,
      super.imageUri,
      required super.duration,
      super.createdAt,
      super.updatedAt,
      required this.answer})
      : super(type: TaskType.checkedText);

  factory PublishedCheckedTextTask.fromOtherTask(Task baseTask, String answer) {
    return PublishedCheckedTextTask(
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        answer: answer);
  }

  @override
  PublishedTask copyWith(
      {String? id,
      String? name,
      String? description,
      String? imageUri,
      int? duration,
      TaskType? type,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? answer}) {
    return PublishedCheckedTextTask(
        id: id ?? super.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        duration: duration ?? super.duration,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt,
        answer: answer ?? this.answer);
  }
}
