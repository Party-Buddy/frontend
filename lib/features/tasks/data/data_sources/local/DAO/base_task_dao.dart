import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';

part 'base_task_dao.g.dart';

@UseDao(tables: [BaseTasks])
class BaseTaskDao extends DatabaseAccessor<AppDatabase>
    with _$BaseTaskDaoMixin {
  final AppDatabase db;

  BaseTaskDao(this.db) : super(db);

  Future<List<LocalBaseTask>> getAllTasks() => select(baseTasks).get();

  Future<List<LocalBaseTask>> getAllTasksByType(String type) {
    return (select(baseTasks)..where((t) => t.type.equals(type))).get();
  }

  Future<int> insertTask(OwnedTaskModel task) =>
      into(baseTasks).insert(task.baseToInsertable());

  Future updateTask(OwnedTaskModel task) =>
      update(baseTasks).replace(task.baseToInsertable());

  Future deleteTask(OwnedTaskModel task) =>
      delete(baseTasks).delete(task.baseToInsertable());
}
