import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';

class GamePlayerModel {
  final int? id;
  final String? name;
  final String? photoUrl;
  final bool? ready;

  const GamePlayerModel({this.id, this.name, this.photoUrl, this.ready});

  GamePlayer toEntity() {
    return GamePlayer(
        id: id ?? 0,
        name: name ?? "",
        photoUrl: photoUrl ?? "",
        ready: ready ?? false);
  }

  factory GamePlayerModel.fromEntity(GamePlayer gamePlayer) {
    return GamePlayerModel(
        id: gamePlayer.id,
        name: gamePlayer.name,
        photoUrl: gamePlayer.photoUrl,
        ready: gamePlayer.ready);
  }

  factory GamePlayerModel.fromJson(Map<String, dynamic> map) {
    return GamePlayerModel(
        id: map['player-id'],
        name: map['nickname'],
        photoUrl: map['image'],
        ready: map['ready']);
  }

  GamePlayerModel copyWith({
    int? id,
    String? name,
    String? photoUrl,
    bool? ready,
  }) {
    return GamePlayerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        photoUrl: photoUrl ?? this.photoUrl,
        ready: ready ?? this.ready);
  }
}
