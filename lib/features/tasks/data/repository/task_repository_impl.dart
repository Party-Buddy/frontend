import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/tasks/data/data_sources/testing/tasks_generator.dart';
import 'package:party_games_app/features/tasks/data/models/task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {

  final TasksGenerator _tasksGenerator;

  TaskRepositoryImpl(this._tasksGenerator);
  
  @override
  Future<List<TaskModel>> getLocalTasks() async {
    return _tasksGenerator.generateTasks(); 
  }

  @override
  Future<DataState<List<Task>>> getPublishedTasks() async {
    return DataSuccess(_tasksGenerator.generateTasks()); 
  }

  @override
  Future<void> removeTask(Task task) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<void> saveTask(Task task) {
    // TODO: implement saveTask
    throw UnimplementedError();
  }

}