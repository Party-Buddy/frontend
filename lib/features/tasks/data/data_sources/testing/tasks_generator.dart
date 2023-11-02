import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TasksGenerator {
  List<Task> generateTasks(){
    return [const Task(id:0, name: "Разминка", description: '2+2', duration: 10, type: TaskType.checkedText)];
  }
}