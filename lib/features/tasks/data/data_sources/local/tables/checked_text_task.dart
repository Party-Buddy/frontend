import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';



@DataClassName('LocalCheckedTextTask')
class CheckedTextTasks extends Table{
  
  IntColumn get baseTaskId => integer().references(BaseTasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get answer => text()();

  @override
  Set<Column> get primaryKey => {baseTaskId};

}
