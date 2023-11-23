import 'package:party_games_app/features/game_sessions/data/models/game_player_model.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/config/consts.dart' as consts;
import 'package:party_games_app/features/players/data/models/player_model.dart';

class GameSessionModel {
  final String? sessionId;
  final String? name;
  final String? description;
  final String? imageUri;
  final int? maxPlayersCount;
  final int? ownerId;
  final int? currentPlayerId;
  final List<GamePlayerModel>? players;

  GameSessionModel(
      {this.sessionId,
      this.name,
      this.description,
      this.imageUri,
      this.maxPlayersCount,
      this.ownerId,
      this.currentPlayerId,
      this.players});

  GameSession toEntity() {
    return GameSession(
        sessionId: sessionId ?? "",
        name: name ?? "",
        description: description ?? "",
        imageUri: imageUri,
        maxPlayersCount: maxPlayersCount ?? consts.maxPlayersCount,
        ownerId: ownerId,
        currentPlayerId: currentPlayerId,
        players: players?.map((player) => player.toEntity()).toList() ?? []);
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
        sessionId: map['sessionId'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageUri'],
        maxPlayersCount: consts.maxPlayersCount,
        ownerId: null,
        currentPlayerId: map['player-id'],
        players: map['players']
                ?.map((player) => PlayerModel.fromJson(player))
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
      List<GamePlayerModel>? players}) {
    return GameSessionModel(
      sessionId: sessionId ?? this.sessionId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUri: imageUri ?? this.imageUri,
      maxPlayersCount: maxPlayersCount ?? this.maxPlayersCount,
      ownerId: ownerId ?? this.ownerId,
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      players: players ?? this.players,
    );
  }
}
