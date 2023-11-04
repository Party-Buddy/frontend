import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/poll_task.dart';
import 'package:party_games_app/features/tasks/data/models/poll_task_model.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';

part 'poll_task_dao.g.dart';

@UseDao(tables: [BaseTasks, PollTasks])
class PollTaskDao extends DatabaseAccessor<AppDatabase> with _$PollTaskDaoMixin {

  final AppDatabase db;

  PollTaskDao(this.db) : super(db);

  Future<TaskModel> getTask(int taskId) {
    return (select(pollTasks)
    ..where((t) => t.baseTaskId.equals(taskId)))
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(pollTasks.baseTaskId))
    ])
    .getSingle()
    .then(
      (row) {
        return PollTaskModel.fromTables(
          row.readTable(baseTasks),
          row.readTable(pollTasks));
      });
  }

  Future<List<TaskModel>> getAllTasks() {
    return select(pollTasks)
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(pollTasks.baseTaskId))
    ])
    .get()
    .then((rows) => rows.map(
      (row) {
        return PollTaskModel.fromTables(
          row.readTable(baseTasks),
          row.readTable(pollTasks));
      })
      .toList()
      );
  }

  Future<int> insertTask(PollTaskModel task) {
    return into(baseTasks).insert(task.baseToInsertable())
    .then((baseId) => into(pollTasks).insert(task.toInsertable(baseId: baseId)));
    }

  Future updateTask(PollTaskModel task) async {
    update(baseTasks).replace(task.baseToInsertable());
    update(pollTasks).replace(task.toInsertable());
    }
  
  Future deleteTask(PollTaskModel task) async {
    delete(baseTasks).delete(task.baseToInsertable());
    }

}