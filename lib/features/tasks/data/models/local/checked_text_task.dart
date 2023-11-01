import 'package:floor/floor.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';

@Entity(tableName: 'checked_text_task', foreignKeys: [
  ForeignKey(
    childColumns: ['base_task_id'],
    parentColumns: ['id'],
    entity: BaseTaskModel,
    onDelete: ForeignKeyAction.cascade
    )
])
class CheckedTextTaskModel{
  
  @PrimaryKey()
  @ColumnInfo(name: 'base_task_id')
  final int baseTaskId;
  final String answer;

  const CheckedTextTaskModel({
    required this.baseTaskId,
    required this.answer
    });

}