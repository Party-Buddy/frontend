
import 'package:floor/floor.dart';
import 'package:party_games_app/features/games/data/models/local_game.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';

@Entity(tableName: 'task_bindings',
foreignKeys: [
  ForeignKey(
    childColumns: ['game_id'],
    parentColumns: ['id'],
    entity: LocalGameModel,
    onDelete: ForeignKeyAction.cascade),
  ForeignKey(
    childColumns: ['base_task_id'],
    parentColumns: ['id'],
    entity: BaseTaskModel,
    onDelete: ForeignKeyAction.restrict)
  ])
class TaskBinding {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'game_id')
  final int gameId;

  @ColumnInfo(name: 'base_task_id')
  final int baseTaskId;


  TaskBinding({required this.id, required this.gameId, required this.baseTaskId});
  
}