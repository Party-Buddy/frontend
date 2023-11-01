import 'package:floor/floor.dart';
import 'package:party_games_app/features/tasks/data/models/local/checked_text_task.dart';

@dao
abstract class CheckedTextTaskDao {

  @Insert()
  Future<void> insertCheckedTextTask(CheckedTextTaskModel taskModel);

  @delete
  Future<void> deleteCheckedTextTask(CheckedTextTaskModel taskModel);

  @Query('SELECT * FROM checked_text_task')
  Future<List<CheckedTextTaskModel>> getCheckedTextTasks();

}