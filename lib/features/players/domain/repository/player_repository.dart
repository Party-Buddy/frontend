import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/players/domain/entities/player.dart';

abstract class PlayerRepository {
  Future<DataState<List<PlayerEntity>>> getPlayers(int gameId);
}
