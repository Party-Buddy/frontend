
import 'package:moor_flutter/moor_flutter.dart';

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
  TextColumn get sourceId => text().withLength(min: 1, max:40).nullable()();

}
