import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/data/data_sources/testing/games_generator.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';

class GameRepositoryImpl implements GameRepository {

  final AppDatabase _database;

  final GamesGenerator _gamesGenerator;

  GameRepositoryImpl(this._gamesGenerator, this._database);
  

  
  // API

  @override
  Future<DataState<List<Game>>> getPublishedGames() async {
    return DataSuccess(_gamesGenerator.generateGames2()); 
  }



  // Database

  @override
  Future<List<Game>> getLocalGames() async {
    var allGames = await _database.gameDao.getAllGames();
    return Future.wait(allGames.map((game) async {
      return GameModel.fromTables(
          game,
          await _database.taskBindingDao.getAllTasks(game.id)
        );
    })).then((e) => e.map((e) => e.toEntity()).toList());
  }

  @override
  Future<Game> saveGame(Game game) {
    return _database.gameDao.insertGame(GameModel.fromEntity(game))
    .then((gameId) {
      Game gameWithId = game.copyWith(id:gameId);
      _database.taskBindingDao.bindAllTasksToGame(GameModel.fromEntity(gameWithId));
      return gameWithId;
      });
  }
  
  @override
  Future<void> removeGame(Game game) {
    // TODO: implement removeGame
    throw UnimplementedError();
  }


  @override
  Future<void> updateGame(Game game) {
    // TODO: implement updateGame
    throw UnimplementedError();
  }

}