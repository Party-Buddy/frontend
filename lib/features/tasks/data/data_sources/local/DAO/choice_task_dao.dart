import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/choice_task_options.dart';
import 'package:party_games_app/features/tasks/data/models/choice_task_model.dart';

part 'choice_task_dao.g.dart';

@UseDao(tables: [BaseTasks, ChoiceTaskOptions])
class ChoiceTaskDao extends DatabaseAccessor<AppDatabase>
    with _$ChoiceTaskDaoMixin {
  final AppDatabase db;

  ChoiceTaskDao(this.db) : super(db);

  Future<List<LocalChoiceTaskOption>> getAllOptions(int baseTaskId) {
    return (select(choiceTaskOptions)
          ..where((tbl) => tbl.baseTaskId.equals(baseTaskId)))
        .get();
  }

  Future bindAllOptionsToTask(ChoiceTaskModel task) async {
    (delete(choiceTaskOptions)
          ..where((option) => option.baseTaskId.equals(task.id)))
        .go()
        .then((_) {
      for (var entry in task.options!) {
        into(choiceTaskOptions)
            .insert(task.toBinding(option: entry));
      }
    });
  }
}
