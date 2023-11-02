import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/local_game.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/task_binding.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/checked_text_task.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

part 'task_binding_dao.g.dart';

@UseDao(tables: [LocalGames, BaseTasks, TaskBindings, CheckedTextTasks])
class TaskBindingDao extends DatabaseAccessor<AppDatabase> with _$TaskBindingDaoMixin {

  final AppDatabase db;

  TaskBindingDao(this.db) : super(db);

  Future<List<TaskModel>> getAllTasks(int gameId) {
    return (select(taskBindings)
    ..where((tbl) => tbl.id.equals(gameId))
    )
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(taskBindings.baseTaskId))
    ])
    .get()
    .then((rows) => Future.wait(rows.map(
      (row) {
        LocalBaseTask baseTask = row.readTable(baseTasks);
        TaskType type = TaskType.values.firstWhere((type) => type.toString() == baseTask.type);
        switch (type) {
          case TaskType.checkedText:
            return db.checkedTextTaskDao.getTask(baseTask.id);
          default:
          throw Error();
        }
        
      })
      ));
  }
  

  Future bindAllTasksToGame(GameModel game) async {
    (delete(taskBindings)
    ..where((binding) => binding.gameId.equals(game.id)))
    .go()
    .then((_) {
      for (var entry in game.tasks!.asMap().entries) {
      int index = entry.key;
      var value = entry.value;
      into(taskBindings).insert(game.toBinding(taskId: value.id));
    }
    });
    
  }

}