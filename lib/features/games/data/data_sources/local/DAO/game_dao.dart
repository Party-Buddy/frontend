import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/local_game.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';

part 'game_dao.g.dart';

@UseDao(tables: [LocalGames])
class GameDao extends DatabaseAccessor<AppDatabase> with _$GameDaoMixin {

  final AppDatabase db;

  GameDao(this.db) : super(db);


  Future<List<LocalGame>> getAllGames() => select(localGames).get();

  Future<List<LocalGame>> getAllGamesSortedByUpdateDate(bool ascending) {
    return (select(localGames)
    ..orderBy([
      (t) => OrderingTerm(expression: t.updatedAt, mode: ascending ? OrderingMode.asc :OrderingMode.desc)
    ]))
    .get();
  }
  
  Future<List<LocalGame>> getAllGamesSortedByName(bool ascending) {
    return (select(localGames)
    ..orderBy([
      (t) => OrderingTerm(expression: t.name, mode: ascending ? OrderingMode.asc :OrderingMode.desc)
    ]))
    .get();
  }

  Future<int> insertGame(GameModel game) => into(localGames).insert(game.toInsertable());

  Future updateGame(GameModel game) => update(localGames).replace(game.toInsertable());

  Future deleteGame(GameModel game) => delete(localGames).delete(game.toInsertable());

}