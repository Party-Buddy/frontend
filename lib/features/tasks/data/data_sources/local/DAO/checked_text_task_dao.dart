import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';
import 'package:party_games_app/features/tasks/data/models/local/checked_text_task.dart';

part 'checked_text_task_dao.g.dart';

@UseDao(tables: [BaseTasks, CheckedTextTasks])
class CheckedTextTaskDao extends DatabaseAccessor<AppDatabase> with _$CheckedTextTaskDaoMixin {

  final AppDatabase db;

  CheckedTextTaskDao(this.db) : super(db);

  Future<CheckedTextTaskModel> getTask(int taskId) {
    return (select(checkedTextTasks)
    ..where((t) => t.baseTaskId.equals(taskId)))
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(checkedTextTasks.baseTaskId))
    ])
    .getSingle()
    .then(
      (row) {
        return CheckedTextTaskModel(baseTask: row.readTable(baseTasks), checkedTextTask: row.readTable(checkedTextTasks));
      });
  }

  Future<List<CheckedTextTaskModel>> getAllTasks() {
    return select(checkedTextTasks)
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(checkedTextTasks.baseTaskId))
    ])
    .get()
    .then((rows) => rows.map(
      (row) {
        return CheckedTextTaskModel(baseTask: row.readTable(baseTasks), checkedTextTask: row.readTable(checkedTextTasks));
      })
      .toList()
      );
  }

  Future<int> insertBaseTask(Insertable<LocalCheckedTextTask> task) => into(checkedTextTasks).insert(task);

  Future updateBaseTask(Insertable<LocalCheckedTextTask> task) => update(checkedTextTasks).replace(task);
  
  Future deleteBaseTask(Insertable<LocalCheckedTextTask> task) => delete(checkedTextTasks).delete(task);

}