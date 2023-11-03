import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/local_game.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';

class TaskBindings extends Table{

  IntColumn get gameOrder => integer()();
  IntColumn get baseTaskId => integer().references(BaseTasks, #id, onDelete: KeyAction.restrict)();
  IntColumn get gameId => integer().references(LocalGames, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {gameId, gameOrder};
  
}