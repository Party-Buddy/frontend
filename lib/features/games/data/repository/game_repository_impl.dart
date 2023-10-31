import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/data/data_sources/testing/games_generator.dart';
import 'package:party_games_app/features/games/data/models/game.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';

class GameRepositoryImpl implements GameRepository {

  final GamesGenerator _gamesGenerator;

  GameRepositoryImpl(this._gamesGenerator);
  
  @override
  Future<List<GameModel>> getLocalGames() async {
    return _gamesGenerator.generateGames1(); 
  }

  @override
  Future<DataState<List<GameModel>>> getPublishedGames() async {
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