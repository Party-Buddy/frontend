import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TasksGenerator {
  List<Task> generateTasks() {
    return [
      const Task(
          id: 0,
          name: "Разминка",
          imageUri: 'https://s.turbifycdn.com/aah/mathmedia/what-is-the-difference-between-arithmetic-and-mathematics-44.jpg',
          description: '2+2',
          duration: 10,
          type: TaskType.checkedText)
    ];
  }
}
