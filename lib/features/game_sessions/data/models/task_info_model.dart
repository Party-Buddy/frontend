import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TaskInfoModel {
  final String? name;
  final String? description;
  final int? duration;
  final String? photoUrl;
  final TaskType? type;
  final PollTaskAnswerType? pollAnswerType;
  final int? pollFixedDuration;
  final int? pollDynamicDuration;

  const TaskInfoModel(
      {this.name,
      this.description,
      this.duration,
      this.photoUrl,
      this.type,
      this.pollAnswerType,
      this.pollFixedDuration,
      this.pollDynamicDuration});

  TaskInfo toEntity() {
    return TaskInfo(
        name: name ?? "",
        description: description ?? "",
        duration: duration ?? 0,
        photoUrl: photoUrl,
        type: type ?? TaskType.checkedText,
        pollAnswerType: pollAnswerType,
        pollFixedDuration: pollFixedDuration,
        pollDynamicDuration: pollDynamicDuration);
  }

  factory TaskInfoModel.fromEntity(TaskInfo taskInfo) {
    return TaskInfoModel(
        name: taskInfo.name,
        description: taskInfo.description,
        duration: taskInfo.duration,
        photoUrl: taskInfo.photoUrl,
        type: taskInfo.type,
        pollAnswerType: taskInfo.pollAnswerType,
        pollFixedDuration: taskInfo.pollFixedDuration,
        pollDynamicDuration: taskInfo.pollDynamicDuration);
  }

  factory TaskInfoModel.fromJson(Map<String, dynamic> map) {

    return TaskInfoModel(
        name: map['name'],
        description: map['description'],
        duration: map['duration'],
        photoUrl: map['img-uri'],
        type: map['type'] == 'checked-text'
            ? TaskType.checkedText
            : (map['type'] == 'choice' ? TaskType.choice : TaskType.poll),
        pollAnswerType: map['type'] == 'text' || map['type'] == 'photo'
            ? (map['type'] == 'text'
                ? PollTaskAnswerType.text
                : PollTaskAnswerType.image)
            : null,
        pollFixedDuration: map['poll-duration']?['kind'] == "fixed"
            ? (map['poll-duration']?['secs'] ?? 0)
            : 0,
        pollDynamicDuration: map['poll-duration']?['kind'] == "dynamic"
            ? (map['poll-duration']?['secs'] ?? 0)
            : 0);
  }
}
