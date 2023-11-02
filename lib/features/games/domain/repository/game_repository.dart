import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

abstract class GameRepository {

  // API

  Future<DataState<List<Game>>> getPublishedGames();



  // Database

  Future<List<Game>> getLocalGames();

  Future<Game> saveGame(Game game);

  Future<void> removeGame(Game game);

  Future<void> updateGame(Game game);

} 