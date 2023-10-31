import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/players/data/models/player_model.dart';
import 'package:party_games_app/features/players/domain/repository/player_repository.dart';

class PlayerRepositoryImpl extends PlayerRepository {
  @override
  Future<DataState<List<PlayerModel>>> getPlayers(int gameId) {
    // TODO: implement getPlayers
    throw UnimplementedError();
  }
}
