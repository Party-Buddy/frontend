import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';

class CurrentTaskModel {
  final int? index;
  final int? deadline;
  final List<String>? options;
  final String? imageUri;

  const CurrentTaskModel({
    this.index,
    this.deadline,
    this.imageUri,
    this.options,
  });

  CurrentTask toEntity() {
    return CurrentTask(
        index: index ?? 0,
        deadline: deadline ?? 0,
        imageUri: imageUri,
        options: options);
  }

  factory CurrentTaskModel.fromEntity(CurrentTask task) {
    return CurrentTaskModel(
        index: task.index,
        deadline: task.deadline,
        imageUri: task.imageUri,
        options: task.options);
  }

  factory CurrentTaskModel.fromJson(Map<String, dynamic> map) {
    return CurrentTaskModel(
      index: map['task-idx'],
      deadline: map['deadline'],
      imageUri: map['img-uri'],
      options: (map['options'] as List<dynamic>?)?.cast<String>().toList(),
    );
  }
}
