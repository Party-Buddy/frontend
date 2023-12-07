import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

abstract class RemoteGamesDataSource {
  Future<DataState<List<Game>>> getGames();
}
