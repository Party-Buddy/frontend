import 'package:floor/floor.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';

@dao
abstract class BaseTaskDao {

  @Insert()
  Future<void> insertBaseTask(BaseTaskModel taskModel);
  
  @delete
  Future<void> deleteBaseTask(BaseTaskModel taskModel);

  @Query('SELECT * FROM task')
  Future<List<BaseTaskModel>> getBaseTasks();

}