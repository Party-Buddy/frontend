import 'package:floor/floor.dart';
import 'package:party_games_app/features/games/data/models/local_game.dart';

@dao
abstract class LocalGameDao {

  @Insert()
  Future<void> insertGame(LocalGameModel gameModel);

  @delete
  Future<void> deleteGame(LocalGameModel gameModel);

  @Query('SELECT * FROM games')
  Future<List<LocalGameModel>> getGames();
}