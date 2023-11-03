import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/tasks/data/data_sources/testing/tasks_generator.dart';
import 'package:party_games_app/features/tasks/data/models/checked_text_task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {

  final AppDatabase _database;
  
  final TasksGenerator _tasksGenerator;

  TaskRepositoryImpl(this._database, this._tasksGenerator);
  

  
  // API

  @override
  Future<DataState<List<Task>>> getPublishedTasks() async {
    return DataSuccess(_tasksGenerator.generateTasks()); 
  }



  // Database

  @override
  Future<List<Task>> getLocalTasks() async {
    return _tasksGenerator.generateTasks(); 
  }

  @override
  Future<Task> saveTask(Task task) async {
    if (task is CheckedTextTask){
      var id = await _database.checkedTextTaskDao.insertTask(CheckedTextTaskModel.fromEntity(task));
      return task.copyWith(id : id);
    }
    else{
      throw Error();
    }
  }
  
  @override
  Future<Task> updateTask(Task task) async {
    if (task is CheckedTextTask){
      await _database.checkedTextTaskDao.updateTask(CheckedTextTaskModel.fromEntity(task));
      return task;
    }
    else{
      throw Error();
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    if (task is CheckedTextTask){
      await _database.checkedTextTaskDao.deleteTask(CheckedTextTaskModel.fromEntity(task));
    }
    else{
      throw Error();
    }
    
  }


}