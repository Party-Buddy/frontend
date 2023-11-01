import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';
import 'package:party_games_app/features/tasks/data/models/local/checked_text_task.dart';

part 'checked_text_task_dao.g.dart';

@UseDao(tables: [BaseTasks, CheckedTextTasks])
class CheckedTextTaskDao extends DatabaseAccessor<AppDatabase> with _$CheckedTextTaskDaoMixin {

  final AppDatabase db;

  CheckedTextTaskDao(this.db) : super(db);

  Future<List<CheckedTextTaskModel>> getAllBaseTasks() {
    return select(checkedTextTasks)
    .join([
      leftOuterJoin(baseTasks, baseTasks.id.equalsExp(checkedTextTasks.baseTaskId))
    ])
    .get()
    .then((rows) => rows.map(
      (row) {
        return CheckedTextTaskModel(baseTask: row.readTable(baseTasks), checkedTextTask: row.readTable(checkedTextTasks));
      }).toList()
      );
  }

  Future<int> insertBaseTask(Insertable<CheckedTextTask> task) => into(checkedTextTasks).insert(task);

  Future updateBaseTask(Insertable<CheckedTextTask> task) => update(checkedTextTasks).replace(task);
  
  Future deleteBaseTask(Insertable<CheckedTextTask> task) => delete(checkedTextTasks).delete(task);

}