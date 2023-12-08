import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/remote_tasks_source.dart';

class TasksGenerator implements RemoteTasksDataSource {
  @override
  Future<DataState<List<PublishedTask>>> getTasks() async {
    return DataSuccess([
      PublishedCheckedTextTask(
          id: '12345678-1234-1234-1234-123456789abc',
          name: "Разминка",
          imageUri:
              'https://s.turbifycdn.com/aah/mathmedia/what-is-the-difference-between-arithmetic-and-mathematics-44.jpg',
          description: '2+2',
          duration: 10,
          answer: '4'),
      PublishedCheckedTextTask(
          id: '11111111-2222-3333-4444-555555555555',
          name: "Заминка",
          imageUri:
              'https://play-lh.googleusercontent.com/4TNXXl8p6TND87TlIXeFGMShtuymvj3yofJtdZFGfI9wRfshxJoTyzC1Ig-WdWuMABo',
          description: '1+8280723',
          duration: 15,
          answer: '8280724')
    ]);
  }
}
