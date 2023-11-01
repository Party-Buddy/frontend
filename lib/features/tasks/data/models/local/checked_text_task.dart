import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';

class CheckedTextTasks extends Table{
  
  IntColumn get baseTaskId => integer().references(BaseTasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get answer => text()();

  @override
  Set<Column> get primaryKey => {baseTaskId};

}

class CheckedTextTaskModel {
  final BaseTask baseTask;
  final CheckedTextTask checkedTextTask;

  CheckedTextTaskModel({required this.baseTask, required this.checkedTextTask});

}