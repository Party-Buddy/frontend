import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';


@DataClassName('LocalCheckedTextTask')
class CheckedTextTasks extends Table{
  
  IntColumn get baseTaskId => integer().references(BaseTasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get answer => text()();

  @override
  Set<Column> get primaryKey => {baseTaskId};

}

class CheckedTextTaskModel extends LocalBaseTaskModel{
  final LocalCheckedTextTask checkedTextTask;

  CheckedTextTaskModel({required super.baseTask, required this.checkedTextTask});

  static Task toEntity(CheckedTextTaskModel task){
    return CheckedTextTask(
      id: task.baseTask.id,
      name: task.baseTask.name,
      description: task.baseTask.description,
      imageUri: task.baseTask.imageUri,
      duration: task.baseTask.duration,
      createdAt: task.baseTask.createdAt,
      updatedAt: task.baseTask.updatedAt,
      answer: task.checkedTextTask.answer);
  }



}