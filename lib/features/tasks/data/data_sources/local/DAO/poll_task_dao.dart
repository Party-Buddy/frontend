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

  Future<OwnedTaskModel> getTask(int taskId) {
    return (select(pollTasks)
    ..where((t) => t.baseTaskId.equals(taskId)))
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(pollTasks.baseTaskId))
    ])
    .getSingle()
    .then(
      (row) {
        return OwnedPollTaskModel.fromTables(
          row.readTable(baseTasks),
          row.readTable(pollTasks));
      });
  }

  Future<List<OwnedTaskModel>> getAllTasks() {
    return select(pollTasks)
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(pollTasks.baseTaskId))
    ])
    .get()
    .then((rows) => rows.map(
      (row) {
        return OwnedPollTaskModel.fromTables(
          row.readTable(baseTasks),
          row.readTable(pollTasks));
      })
      .toList()
      );
  }

  Future<int> insertTask(OwnedPollTaskModel task) {
    return into(baseTasks).insert(task.baseToInsertable())
    .then((baseId) => into(pollTasks).insert(task.toInsertable(baseId: baseId)));
    }

  Future updateTask(OwnedPollTaskModel task) async {
    update(baseTasks).replace(task.baseToInsertable());
    update(pollTasks).replace(task.toInsertable());
    }
  
  Future<int> deleteTask(OwnedPollTaskModel task) async {
    return delete(baseTasks).delete(task.baseToInsertable());
    }

}