import 'package:party_games_app/features/game_sessions/data/models/game_player_model.dart';
import 'package:party_games_app/features/game_sessions/data/models/task_info_model.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/config/consts.dart' as consts;

class GameSessionModel {
  final String? sessionId;
  final String? name;
  final String? description;
  final String? imageUri;
  final int? maxPlayersCount;
  final int? ownerId;
  final int? currentPlayerId;
  final List<GamePlayerModel>? players;
  final List<TaskInfoModel>? tasks;

  GameSessionModel(
      {this.sessionId,
      this.name,
      this.description,
      this.imageUri,
      this.maxPlayersCount,
      this.ownerId,
      this.currentPlayerId,
      this.players,
      this.tasks});

  GameSession toEntity() {
    return GameSession(
        sessionId: sessionId ?? "",
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        maxPlayersCount: maxPlayersCount ?? consts.maxPossiblePlayersCount,
        ownerId: ownerId,
        currentPlayerId: currentPlayerId,
        players: players?.map((player) => player.toEntity()).toList() ?? [],
        tasks: tasks?.map((task) => task.toEntity()).toList() ?? []);
  }

  factory GameSessionModel.fromEntity(GameSession gameSession) {
    return GameSessionModel(
        sessionId: gameSession.sessionId,
        name: gameSession.name,
        description: gameSession.description,
        imageUri: gameSession.imageUri,
        maxPlayersCount: gameSession.maxPlayersCount,
        ownerId: gameSession.ownerId,
        currentPlayerId: gameSession.currentPlayerId,
        players: gameSession.players
            .map((player) => GamePlayerModel.fromEntity(player))
            .toList());
  }

  factory GameSessionModel.fromJson(Map<String, dynamic> map) {
    return GameSessionModel(
        sessionId: map['session-id'],
        name: map['game']?['name'],
        description: map['game']?['description'],
        imageUri: map['game']?['img-uri'],
        maxPlayersCount: map['max-players'],
        ownerId: null,
        currentPlayerId: map['player-id'],
        tasks: (map['game']?['tasks'] as List?)
                ?.map((task) => TaskInfoModel.fromJson(task))
                .toList() ??
            []);
  }

  GameSessionModel copyWith(
      {String? sessionId,
      String? name,
      String? description,
      String? imageUri,
      int? maxPlayersCount,
      int? ownerId,
      int? currentPlayerId,
      List<TaskInfoModel>? tasks,
      List<GamePlayerModel>? players}) {
    return GameSessionModel(
      sessionId: sessionId ?? this.sessionId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUri: imageUri ?? this.imageUri,
      maxPlayersCount: maxPlayersCount ?? this.maxPlayersCount,
      ownerId: ownerId ?? this.ownerId,
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      tasks: tasks ?? this.tasks,
      players: players ?? this.players,
    );
  }
}
