
import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/models/local/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

@DataClassName('LocalBaseTask')
class BaseTasks extends Table{
  
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 30)();
  TextColumn get description => text().withLength(min: 1, max: 255)();
  TextColumn get imageUri => text().nullable()();
  IntColumn get duration => integer()();
  TextColumn get type => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

}

class LocalBaseTaskModel {

  final LocalBaseTask baseTask;

  LocalBaseTaskModel({required this.baseTask});

  /*
  factory LocalBaseTaskModel.fromDataClass(DataClass task){
    if (task is LocalCheckedTextTask) {
      return CheckedTextTaskModel.fromDataClass(task);
    }
    else{
      throw Error();
    }
  }
  */

  static Task toEntity(LocalBaseTaskModel task){
    if (task is CheckedTextTaskModel) {
      return CheckedTextTaskModel.toEntity(task);
    }
    else{
      throw Error();
    }
  }
}