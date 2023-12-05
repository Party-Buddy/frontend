import 'package:party_games_app/features/game_sessions/domain/entities/poll_info.dart';

class PollInfoModel {
  final int? index;
  final int? deadline;
  final List<String>? options;

  const PollInfoModel({this.index, this.deadline, this.options});

  PollInfo toEntity() {
    return PollInfo(
        index: index ?? 0, deadline: deadline ?? 0, options: options ?? []);
  }

  factory PollInfoModel.fromJson(Map<String, dynamic> map) {
    return PollInfoModel(
      index: map['task-idx'],
      deadline: map['deadline'],
      options: map['options']
    );
  }
}
