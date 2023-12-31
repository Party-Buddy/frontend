import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {

  // API

  Future<DataState<List<PublishedTask>>> getPublishedTasks();



  // Database

  Future<List<OwnedTask>> getLocalTasks();

  Future<OwnedTask> saveTask(Task task);

  Future<Task> updateTask(Task task);

  Future<bool> deleteTask(Task task);

} 