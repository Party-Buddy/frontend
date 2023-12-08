import 'package:flutter/material.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/repository/remote_games_source.dart';
import 'package:party_games_app/features/tasks/data/models/choice_task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final AppDatabase _database;

  final RemoteGamesDataSource _remoteGamesDataSource;

  final TaskRepository _taskRepository;

  GameRepositoryImpl(
      this._remoteGamesDataSource, this._database, this._taskRepository);

  // API

  @override
  Future<DataState<List<Game>>> getPublishedGames() {
    return _remoteGamesDataSource.getGames();
  }

  // Database

  Future<List<Game>> _gamesWithBindings(List<LocalGame> games) {
    return Future.wait(games.map((game) async {
      return OwnedGameModel.fromTables(
          game,
          await _database.taskBindingDao
              .getAllTasks(game.id)
              .then((baseTasks) => Future.wait(baseTasks.map((task) async {
                    TaskType type = TaskType.values.firstWhere(
                        (element) => element.toString() == task.type);
                    switch (type) {
                      case TaskType.checkedText:
                        return _database.checkedTextTaskDao.getTask(task.id);
                      case TaskType.poll:
                        return _database.pollTaskDao.getTask(task.id);
                      case TaskType.choice:
                        return OwnedChoiceTaskModel.fromTables(
                            task,
                            await _database.choiceTaskDao
                                .getAllOptions(task.id)
                                .then((options) => options
                                    .map((option) => ChoiceTaskOption(
                                        alternative: option.answer,
                                        correct: option.correct))
                                    .toList()));
                      default:
                        throw Error();
                    }
                  }))));
    })).then((games) => games.map((game) => game.toEntity()).toList());
  }

  @override
  Future<List<Game>> getLocalGames() async {
    var allGames = await _database.gameDao.getAllGames();
    return _gamesWithBindings(allGames);
  }

  @override
  Future<List<Game>> getLocalGamesSortedByName(bool ascending) async {
    var allGames = await _database.gameDao.getAllGamesSortedByName(ascending);
    return _gamesWithBindings(allGames);
  }

  @override
  Future<List<Game>> getLocalGamesSortedByUpdateDate(bool ascending) async {
    var allGames =
        await _database.gameDao.getAllGamesSortedByUpdateDate(ascending);
    return _gamesWithBindings(allGames);
  }

  Future<List<OwnedTask>> _saveTasks(List<Task> tasks) {
    return Future.wait(tasks.map((task) async {
      if (task is OwnedTask) {
        return task;
      } else if (task is PublishedTask) {
        return _taskRepository.saveTask(task);
      } else {
        throw ('meow');
      }
    }));
  }

  @override
  Future<Game> saveGame(Game game) async {
    if (game is OwnedGame) {
      return _database.gameDao
          .insertGame(OwnedGameModel.fromEntity(game))
          .then((gameId) async {
        List<OwnedTask> savedTasks = await _saveTasks(game.tasks);
        OwnedGame gameWithId = game.copyWith(id: gameId, tasks: savedTasks);
        _database.taskBindingDao
            .bindAllTasksToGame(OwnedGameModel.fromEntity(gameWithId));
        return gameWithId;
      });
    } else {
      debugPrint('cannot save public games right now');
      return game;
    }
  }

  @override
  Future<void> deleteGame(Game game) async {
    if (game is OwnedGame) {
      await _database.gameDao.deleteGame(OwnedGameModel.fromEntity(game));
    }
    {
      debugPrint('cannot delete public games right now');
    }
  }

  @override
  Future<Game> updateGame(Game game) async {
    if (game is OwnedGame) {
      return _database.gameDao
          .updateGame(OwnedGameModel.fromEntity(game))
          .then((gameId) {
        OwnedGame gameWithId = game.copyWith(id: gameId);
        _database.taskBindingDao
            .bindAllTasksToGame(OwnedGameModel.fromEntity(gameWithId));
        return gameWithId;
      });
    } else {
      debugPrint('cannot update public games right now');
      return game;
    }
  }
}
