import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';

@DataClassName('LocalGame')
class LocalGames extends Table{
  
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 30)();
  TextColumn get description => text().nullable().withLength(min: 1, max: 255)();
  TextColumn get imageUri => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

}

class GameModel {
  final LocalGame localGame;
  final List<LocalBaseTaskModel>? tasks; 
  GameModel({required this.localGame, required this.tasks});

  Game toEntity(){
    return Game(
      id: localGame.id,
      name: localGame.name,
      description: localGame.description,
      imageUri: localGame.imageUri,
      tasks: tasks?.map(LocalBaseTaskModel.toEntity).toList() ?? [],
      createdAt: localGame.createdAt,
      updatedAt: localGame.updatedAt);
  }


}