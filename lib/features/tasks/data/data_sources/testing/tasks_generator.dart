import 'package:party_games_app/features/tasks/data/models/task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TasksGenerator {
  List<TaskModel> generateTasks(){
    return [const TaskModel(name: "Разминка", description: '2+2', duration: 10, type: TaskTypes.checkedText)];
  }
}