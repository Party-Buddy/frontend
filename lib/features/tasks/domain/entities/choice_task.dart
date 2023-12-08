import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class ChoiceTaskOption {
  final String alternative;
  final bool correct;

  const ChoiceTaskOption({required this.alternative, required this.correct});
}

class OwnedChoiceTask extends OwnedTask {
  final Set<ChoiceTaskOption> options;

  OwnedChoiceTask(
      {super.id,
      super.sourceId,
      required super.name,
      required super.description,
      super.imageUri,
      required super.duration,
      super.createdAt,
      super.updatedAt,
      required this.options})
      : super(type: TaskType.choice);

  factory OwnedChoiceTask.fromOtherTask(
      Task baseTask, Set<ChoiceTaskOption> options) {
    return OwnedChoiceTask(
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        options: options);
  }

  @override
  OwnedTask copyWith(
      {int? id,
      String? sourceId,
      String? name,
      String? description,
      String? imageUri,
      int? duration,
      TaskType? type,
      DateTime? createdAt,
      DateTime? updatedAt,
      Set<ChoiceTaskOption>? options}) {
    return OwnedChoiceTask(
        id: id ?? super.id,
        sourceId: sourceId ?? super.sourceId,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        duration: duration ?? super.duration,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt,
        options: options ?? this.options);
  }
}

class PublishedChoiceTask extends PublishedTask {
  final Set<ChoiceTaskOption> options;

  PublishedChoiceTask(
      {super.id,
      required super.name,
      required super.description,
      super.imageUri,
      required super.duration,
      super.createdAt,
      super.updatedAt,
      required this.options})
      : super(type: TaskType.choice);

  factory PublishedChoiceTask.fromOtherTask(
      Task baseTask, Set<ChoiceTaskOption> options) {
    return PublishedChoiceTask(
        name: baseTask.name,
        description: baseTask.description,
        imageUri: baseTask.imageUri,
        duration: baseTask.duration,
        createdAt: baseTask.createdAt,
        updatedAt: baseTask.updatedAt,
        options: options);
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
      Set<ChoiceTaskOption>? options}) {
    return PublishedChoiceTask(
        id: id ?? super.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        duration: duration ?? super.duration,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt,
        options: options ?? this.options);
  }
}
