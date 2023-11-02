import 'package:get_it/get_it.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/games/data/data_sources/testing/games_generator.dart';
import 'package:party_games_app/features/games/data/repository/game_repository_impl.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/usecases/get_local_games.dart';
import 'package:party_games_app/features/games/domain/usecases/get_published_games.dart';
import 'package:party_games_app/features/games/domain/usecases/save_game.dart';
import 'package:party_games_app/features/tasks/data/data_sources/testing/tasks_generator.dart';
import 'package:party_games_app/features/tasks/data/repository/task_repository_impl.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_local_tasks.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_published_tasks.dart';
import 'package:party_games_app/features/tasks/domain/usecases/save_task.dart';

final sl = GetIt.instance;

Future<void> initializeDependenices() async {

  // database
  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);



  // repositories
  //   games
  sl.registerSingleton<GamesGenerator>(GamesGenerator());
  sl.registerSingleton<GameRepository>(GameRepositoryImpl(sl(),sl()));
  //   tasks
  sl.registerSingleton<TasksGenerator>(TasksGenerator());
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl(), sl()));



  // usecases
  //   games
  sl.registerSingleton(GetPublishedGamesUseCase(sl()));
  sl.registerSingleton(GetLocalGamesUseCase(sl()));
  sl.registerSingleton(SaveGameUseCase(sl()));
  //   tasks
  sl.registerSingleton(GetPublishedTasksUseCase(sl()));
  sl.registerSingleton(GetLocalTasksUseCase(sl()));
  sl.registerSingleton(SaveTaskUseCase(sl()));

}
