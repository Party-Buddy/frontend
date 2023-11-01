import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/models/local_game.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';

class TaskBindings extends Table{

  IntColumn get id => integer().autoIncrement()();
  IntColumn get baseTaskId => integer().references(BaseTasks, #id, onDelete: KeyAction.restrict)();
  IntColumn get gameId => integer().references(LocalGames, #id, onDelete: KeyAction.cascade)();

}