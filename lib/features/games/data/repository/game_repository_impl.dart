import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/data/data_sources/testing/games_generator.dart';
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/tasks/data/models/choice_task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class GameRepositoryImpl implements GameRepository {
  final AppDatabase _database;

  final GamesGenerator _gamesGenerator;

  GameRepositoryImpl(this._gamesGenerator, this._database);

  // API

  @override
  Future<DataState<List<Game>>> getPublishedGames() async {
    return DataSuccess(_gamesGenerator.generateGames2());
  }

  // Database

  @override
  Future<List<Game>> getLocalGames() async {
    var allGames = await _database.gameDao.getAllGames();
    return Future.wait(allGames.map((game) async {
      return GameModel.fromTables(
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
                        return ChoiceTaskModel.fromTables(
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
  Future<Game> saveGame(Game game) {
    return _database.gameDao
        .insertGame(GameModel.fromEntity(game))
        .then((gameId) {
      Game gameWithId = game.copyWith(id: gameId);
      _database.taskBindingDao
          .bindAllTasksToGame(GameModel.fromEntity(gameWithId));
      return gameWithId;
    });
  }

  @override
  Future<void> deleteGame(Game game) async {
    await _database.gameDao.deleteGame(GameModel.fromEntity(game));
  }

  @override
  Future<Game> updateGame(Game game) async {
    await _database.gameDao.updateGame(GameModel.fromEntity(game));
    return game;
  }
}
