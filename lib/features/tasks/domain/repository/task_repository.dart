import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {

  // API

  Future<DataState<List<Task>>> getPublishedTasks();



  // Database

  Future<List<Task>> getLocalTasks();

  Future<Task> saveTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> removeTask(Task task);

} 