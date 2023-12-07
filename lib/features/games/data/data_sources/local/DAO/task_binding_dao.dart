import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/local_game.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/task_binding.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/checked_text_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/choice_task_options.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/poll_task.dart';

part 'task_binding_dao.g.dart';

@UseDao(tables: [
  LocalGames,
  BaseTasks,
  TaskBindings,
  CheckedTextTasks,
  PollTasks,
  ChoiceTaskOptions
])
class TaskBindingDao extends DatabaseAccessor<AppDatabase>
    with _$TaskBindingDaoMixin {
  final AppDatabase db;

  TaskBindingDao(this.db) : super(db);

  Future<List<LocalBaseTask>> getAllTasks(int gameId) {
    return (select(taskBindings)
          ..where((tbl) => tbl.gameId.equals(gameId))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.baseTaskId, mode: OrderingMode.asc)
          ]))
        .join([
          leftOuterJoin(
              baseTasks, baseTasks.id.equalsExp(taskBindings.baseTaskId))
        ])
        .get()
        .then((rows) => Future.wait(rows.map((row) async {
              return row.readTable(baseTasks);
            })));
  }

  Future bindAllTasksToGame(GameModel game) async {
    (delete(taskBindings)..where((binding) => binding.gameId.equals(game.id)))
        .go()
        .then((_) {
      for (var entry in game.tasks!.asMap().entries) {
        int index = entry.key;
        var value = entry.value;
        into(taskBindings)
            .insert(game.toBinding(taskId: value.id, taskOrder: index));
      }
    });
  }
}
