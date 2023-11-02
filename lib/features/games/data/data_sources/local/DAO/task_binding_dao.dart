import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/games/data/models/local_game.dart';
import 'package:party_games_app/features/games/data/models/task_binding.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';
import 'package:party_games_app/features/tasks/data/models/local/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

part 'task_binding_dao.g.dart';

@UseDao(tables: [LocalGames, BaseTasks, TaskBindings, CheckedTextTasks])
class TaskBindingDao extends DatabaseAccessor<AppDatabase> with _$TaskBindingDaoMixin {

  final AppDatabase db;

  TaskBindingDao(this.db) : super(db);

  Future<List<LocalBaseTaskModel>> getAllTasks(int gameId) {
    return (select(taskBindings)
    ..where((tbl) => tbl.id.equals(gameId))
    )
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(taskBindings.baseTaskId))
    ])
    .get()
    .then((rows) => rows.map(
      (row) {
        LocalBaseTask baseTask = row.readTable(baseTasks);
        TaskType type = TaskType.values.firstWhere((type) => type.toString() == 'TaskType.${baseTask.type}');
        switch (type) {
          case TaskType.checkedText:
            return db.checkedTextTaskDao.getTask(baseTask.id);
          default:
          throw Error();
        }
        
      })
      .toList()
      .cast<CheckedTextTaskModel>()
      );
  }
  

  Future<int> bindAllTasksToGame(LocalGame game) => throw UnimplementedError();

}