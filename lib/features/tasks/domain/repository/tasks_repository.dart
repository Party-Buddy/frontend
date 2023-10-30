import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

abstract class TasksRepository {

  Future<DataState<List<Task>>> getLocalTasks();
} 