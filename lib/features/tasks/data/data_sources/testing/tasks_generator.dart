import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class TasksGenerator {
  List<Task> generateTasks() {
    return [
      const CheckedTextTask(
          id: 0,
          name: "Разминка",
          imageUri: 'https://s.turbifycdn.com/aah/mathmedia/what-is-the-difference-between-arithmetic-and-mathematics-44.jpg',
          description: '2+2',
          duration: 10,
          answer: '4'),
      const CheckedTextTask(
          id: 1,
          name: "Заминка",
          imageUri: 'https://play-lh.googleusercontent.com/4TNXXl8p6TND87TlIXeFGMShtuymvj3yofJtdZFGfI9wRfshxJoTyzC1Ig-WdWuMABo',
          description: '1+8280723',
          duration: 15,
          answer: '8280724'
      )
    ];
  }
}
