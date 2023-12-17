import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/core/resources/data_state.dart';
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
        .getAllTasksByType(TaskType.choice.toString())
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

  Future<OwnedTask> _saveCheckedTextTask(OwnedCheckedTextTaskModel task) async {
    var id = await _database.checkedTextTaskDao.insertTask(task);
    return task.toEntity().copyWith(id: id);
  }

  Future<OwnedTask> _savePollTask(OwnedPollTaskModel task) async {
    var id = await _database.pollTaskDao.insertTask(task);
    return task.toEntity().copyWith(id: id);
  }

  Future<OwnedTask> _saveChoiceTask(OwnedChoiceTaskModel task) async {
    var id = await _database.baseTaskDao.insertTask(task);
    OwnedChoiceTask newTask =
        task.toEntity().copyWith(id: id) as OwnedChoiceTask;
    await _database.choiceTaskDao
        .bindAllOptionsToTask(OwnedChoiceTaskModel.fromEntity(newTask));
    return newTask;
  }

  @override
  Future<OwnedTask> saveTask(Task task) async {
    if (task is OwnedCheckedTextTask) {
      return _saveCheckedTextTask(OwnedCheckedTextTaskModel.fromEntity(task));
    } else if (task is PublishedCheckedTextTask) {
      int? sourceId = (task.id == null)
          ? null
          : await _database.baseTaskDao.existsSource(task.id!);
      if (sourceId == null) {
        return _saveCheckedTextTask(
            PublishedCheckedTextTaskModel.fromEntity(task).makeOwned());
      } else {
        return updateTask(PublishedCheckedTextTaskModel.fromEntity(task)
            .makeOwned()
            .toEntity()
            .copyWith(id: sourceId));
      }
    } else if (task is OwnedPollTask) {
      return _savePollTask(OwnedPollTaskModel.fromEntity(task));
    } else if (task is PublishedPollTask) {
      int? sourceId = task.id == null
          ? null
          : await _database.baseTaskDao.existsSource(task.id!);
      if (sourceId == null) {
        return _savePollTask(
            PublishedPollTaskModel.fromEntity(task).makeOwned());
      } else {
        return updateTask(PublishedPollTaskModel.fromEntity(task)
            .makeOwned()
            .toEntity()
            .copyWith(id: sourceId));
      }
    } else if (task is OwnedChoiceTask) {
      return _saveChoiceTask(OwnedChoiceTaskModel.fromEntity(task));
    } else if (task is PublishedChoiceTask) {
      int? sourceId = task.id == null
          ? null
          : await _database.baseTaskDao.existsSource(task.id!);
      if (sourceId == null) {
        return _saveChoiceTask(
            PublishedChoiceTaskModel.fromEntity(task).makeOwned());
      } else {
        return updateTask(PublishedChoiceTaskModel.fromEntity(task)
            .makeOwned()
            .toEntity()
            .copyWith(id: sourceId));
      }
    } else {
      throw Error();
    }
  }

  @override
  Future<OwnedTask> updateTask(Task task) async {
    if (task is OwnedCheckedTextTask) {
      OwnedCheckedTextTask newTask =
          task.copyWith(sourceId: null) as OwnedCheckedTextTask;
      await _database.checkedTextTaskDao
          .updateTask(OwnedCheckedTextTaskModel.fromEntity(newTask));
      return newTask;
    } else if (task is OwnedPollTask) {
      OwnedPollTask newTask = task.copyWith(sourceId: null) as OwnedPollTask;
      await _database.pollTaskDao
          .updateTask(OwnedPollTaskModel.fromEntity(newTask));
      return newTask;
    } else if (task is OwnedChoiceTask) {
      OwnedChoiceTask newTask =
          task.copyWith(sourceId: null) as OwnedChoiceTask;
      await _database.baseTaskDao
          .updateTask(OwnedChoiceTaskModel.fromEntity(newTask));
      await _database.choiceTaskDao
          .bindAllOptionsToTask(OwnedChoiceTaskModel.fromEntity(newTask));
      return newTask;
    } else {
      throw Error();
    }
  }

  @override
  Future<bool> deleteTask(Task task) async {
    if (task is OwnedCheckedTextTask) {
      return _database.checkedTextTaskDao
          .deleteTask(OwnedCheckedTextTaskModel.fromEntity(task))
          .then((rows) => rows > 0);
    } else if (task is OwnedPollTask) {
      return _database.pollTaskDao
          .deleteTask(OwnedPollTaskModel.fromEntity(task))
          .then((rows) => rows > 0);
    } else if (task is OwnedChoiceTask) {
      return _database.baseTaskDao
          .deleteTask(OwnedChoiceTaskModel.fromEntity(task))
          .then((rows) => rows > 0);
      //options are removed by cascade
    } else {
      throw Error();
    }
  }
}
