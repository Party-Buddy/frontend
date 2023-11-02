import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('LocalGame')
class LocalGames extends Table{
  
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 30)();
  TextColumn get description => text().nullable().withLength(min: 1, max: 255)();
  TextColumn get imageUri => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

}