import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/tasks/data/data_sources/testing/tasks_generator.dart';
import 'package:party_games_app/features/tasks/data/models/checked_text_task_model.dart';
import 'package:party_games_app/features/tasks/data/models/choice_task_model.dart';
import 'package:party_games_app/features/tasks/data/models/poll_task_model.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/remote_tasks_source.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final AppDatabase _database;

  final RemoteTasksDataSource _remoteTasksDataSource;

  TaskRepositoryImpl(this._database, this._remoteTasksDataSource);

  // API

  @override
  Future<DataState<List<PublishedTask>>> getPublishedTasks() async {
    return _remoteTasksDataSource.getTasks();
  }

  // Database

  @override
  Future<List<OwnedTask>> getLocalTasks() async {
    List<OwnedTaskModel> allTasks = await _database.baseTaskDao
        .getAllTasksByType(TaskType.choice.name)
        .then((baseTasks) => Future.wait(baseTasks.map((baseTask) async {
              return OwnedChoiceTaskModel.fromTables(
                  baseTask,
                  await _database.choiceTaskDao.getAllOptions(baseTask.id).then(
                      (options) => options
                          .map((option) => ChoiceTaskOption(
                              alternative: option.answer,
                              correct: option.correct))
                          .toList()));
            })));
    allTasks.addAll((await _database.checkedTextTaskDao.getAllTasks()));
    allTasks.addAll((await _database.pollTaskDao.getAllTasks()));
    return allTasks.map((task) => task.toEntity()).toList();
  }

  @override
  Future<Task> saveTask(Task task) async {
    if (task is OwnedCheckedTextTask) {
      var id = await _database.checkedTextTaskDao
          .insertTask(OwnedCheckedTextTaskModel.fromEntity(task));
      return task.copyWith(id: id);
    } else if (task is OwnedPollTask) {
      var id = await _database.pollTaskDao
          .insertTask(OwnedPollTaskModel.fromEntity(task));
      return task.copyWith(id: id);
    } else if (task is OwnedChoiceTask) {
      var id = await _database.baseTaskDao
          .insertTask(OwnedChoiceTaskModel.fromEntity(task));
      OwnedChoiceTask newTask = task.copyWith(id: id) as OwnedChoiceTask;
      await _database.choiceTaskDao
          .bindAllOptionsToTask(OwnedChoiceTaskModel.fromEntity(newTask));
      return newTask;
    } else {
      throw Error();
    }
  }

  @override
  Future<Task> updateTask(Task task) async {
    if (task is OwnedCheckedTextTask) {
      await _database.checkedTextTaskDao
          .updateTask(OwnedCheckedTextTaskModel.fromEntity(task));
      return task;
    } else if (task is OwnedPollTask) {
      await _database.pollTaskDao.updateTask(OwnedPollTaskModel.fromEntity(task));
      return task;
    } else if (task is OwnedChoiceTask) {
      await _database.baseTaskDao.updateTask(OwnedChoiceTaskModel.fromEntity(task));
      await _database.choiceTaskDao
          .bindAllOptionsToTask(OwnedChoiceTaskModel.fromEntity(task));
      return task;
    } else {
      throw Error();
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    if (task is OwnedCheckedTextTask) {
      await _database.checkedTextTaskDao
          .deleteTask(OwnedCheckedTextTaskModel.fromEntity(task));
    } else if (task is OwnedPollTask) {
      await _database.pollTaskDao.deleteTask(OwnedPollTaskModel.fromEntity(task));
    } else if (task is OwnedChoiceTask) {
      await _database.baseTaskDao.deleteTask(OwnedChoiceTaskModel.fromEntity(task));
      //options are removed by cascade
    } else {
      throw Error();
    }
  }
}
