import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/games/data/data_sources/testing/games_generator.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';

class GameRepositoryImpl implements GameRepository {

  final AppDatabase _database;

  final GamesGenerator _gamesGenerator;

  GameRepositoryImpl(this._gamesGenerator, this._database);
  
  @override
  Future<List<Game>> getLocalGames() async {
    return _database.gameDao.getAllGames(); 
  }

  @override
  Future<DataState<List<Game>>> getPublishedGames() async {
    return DataSuccess(_gamesGenerator.generateGames2()); 
  }

  @override
  Future<void> removeGame(Game game) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<void> saveGame(Game game) {
    // TODO: implement saveTask
    throw UnimplementedError();
  }

}