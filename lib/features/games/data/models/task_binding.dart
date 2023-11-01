import 'package:moor_flutter/moor_flutter.dart';

class TaskBindings extends Table{

  IntColumn get id => integer().autoIncrement()();
  IntColumn get baseTaskId => integer().customConstraint('REFERENCES base_tasks(id)')();
  IntColumn get gameId => integer().customConstraint('REFERENCES games(id)')();

}