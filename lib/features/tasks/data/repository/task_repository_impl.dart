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
    List<TaskModel> allTasks = await _database.baseTaskDao
        .getAllTasksByType(TaskType.choice.name)
        .then((baseTasks) => Future.wait(baseTasks.map((baseTask) async {
              return ChoiceTaskModel.fromTables(
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
    if (task is CheckedTextTask) {
      var id = await _database.checkedTextTaskDao
          .insertTask(CheckedTextTaskModel.fromEntity(task));
      return task.copyWith(id: id);
    } else if (task is PollTask) {
      var id = await _database.pollTaskDao
          .insertTask(PollTaskModel.fromEntity(task));
      return task.copyWith(id: id);
    } else if (task is ChoiceTask) {
      var id = await _database.baseTaskDao
          .insertTask(ChoiceTaskModel.fromEntity(task));
      ChoiceTask newTask = task.copyWith(id: id) as ChoiceTask;
      await _database.choiceTaskDao
          .bindAllOptionsToTask(ChoiceTaskModel.fromEntity(newTask));
      return newTask;
    } else {
      throw Error();
    }
  }

  @override
  Future<Task> updateTask(Task task) async {
    if (task is CheckedTextTask) {
      await _database.checkedTextTaskDao
          .updateTask(CheckedTextTaskModel.fromEntity(task));
      return task;
    } else if (task is PollTask) {
      await _database.pollTaskDao.updateTask(PollTaskModel.fromEntity(task));
      return task;
    } else if (task is ChoiceTask) {
      await _database.baseTaskDao.updateTask(ChoiceTaskModel.fromEntity(task));
      await _database.choiceTaskDao
          .bindAllOptionsToTask(ChoiceTaskModel.fromEntity(task));
      return task;
    } else {
      throw Error();
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    if (task is CheckedTextTask) {
      await _database.checkedTextTaskDao
          .deleteTask(CheckedTextTaskModel.fromEntity(task));
    } else if (task is PollTask) {
      await _database.pollTaskDao.deleteTask(PollTaskModel.fromEntity(task));
    } else if (task is ChoiceTask) {
      await _database.baseTaskDao.deleteTask(ChoiceTaskModel.fromEntity(task));
      //options are removed by cascade
    } else {
      throw Error();
    }
  }
}
