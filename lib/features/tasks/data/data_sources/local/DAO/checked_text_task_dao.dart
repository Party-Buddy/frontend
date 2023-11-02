import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/checked_text_task.dart';
import 'package:party_games_app/features/tasks/data/models/checked_text_task_model.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';

part 'checked_text_task_dao.g.dart';

@UseDao(tables: [BaseTasks, CheckedTextTasks])
class CheckedTextTaskDao extends DatabaseAccessor<AppDatabase> with _$CheckedTextTaskDaoMixin {

  final AppDatabase db;

  CheckedTextTaskDao(this.db) : super(db);

  Future<TaskModel> getTask(int taskId) {
    return (select(checkedTextTasks)
    ..where((t) => t.baseTaskId.equals(taskId)))
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(checkedTextTasks.baseTaskId))
    ])
    .getSingle()
    .then(
      (row) {
        return CheckedTextTaskModel.fromTables(
          row.readTable(baseTasks),
          row.readTable(checkedTextTasks));
      });
  }

  Future<List<TaskModel>> getAllTasks() {
    return select(checkedTextTasks)
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(checkedTextTasks.baseTaskId))
    ])
    .get()
    .then((rows) => rows.map(
      (row) {
        return CheckedTextTaskModel.fromTables(
          row.readTable(baseTasks),
          row.readTable(checkedTextTasks));
      })
      .toList()
      );
  }

  Future<int> insertTask(CheckedTextTaskModel task) {
    return into(baseTasks).insert(task.baseToInsertable())
    .then((baseId) => into(checkedTextTasks).insert(task.toInsertable(baseId: baseId)));
    }

  Future updateBaseTask(CheckedTextTaskModel task) async {
    update(baseTasks).replace(task.baseToInsertable());
    update(checkedTextTasks).replace(task.toInsertable());
    }
  
  Future deleteBaseTask(CheckedTextTaskModel task) async {
    delete(baseTasks).delete(task.baseToInsertable());
    }

}