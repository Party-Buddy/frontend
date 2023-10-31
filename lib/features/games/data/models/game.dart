import 'package:party_games_app/features/games/domain/entities/game.dart';

class GameModel extends Game{
  
  const GameModel({
    required super.name,
    super.imageId,
    required super.tasks,
    required super.lastModifiedTime});

    factory GameModel.fromJson(Map<String, dynamic> map) {
      return GameModel(
        name: map['name'],
        imageId: map['imageId'] ?? "",
        tasks: map['tasks'],
        lastModifiedTime: map['lastModifiedTime']
      );
    }

}