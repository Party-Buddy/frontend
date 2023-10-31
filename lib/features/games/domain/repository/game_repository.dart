import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

abstract class GameRepository {

  // API
  Future<DataState<List<Game>>> getPublishedGames();


  // Database
  Future<List<Game>> getLocalGames();

  Future<void> saveGame(Game task);

  Future<void> removeGame(Game task);

} 