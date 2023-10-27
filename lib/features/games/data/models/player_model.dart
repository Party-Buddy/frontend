import 'package:party_games_app/features/players/domain/entities/player.dart';

class PlayerModel extends PlayerEntity {
  const PlayerModel({required super.id, super.name, super.photoUrl});

  factory PlayerModel.fromJson(Map<String, dynamic> map) {
    return PlayerModel(
        id: map['id'], name: map['name'] ?? "", photoUrl: map['photo_url']);
  }
}
