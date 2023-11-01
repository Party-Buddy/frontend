import 'package:get_it/get_it.dart';
import 'package:party_games_app/features/games/data/data_sources/testing/games_generator.dart';
import 'package:party_games_app/features/games/data/repository/game_repository_impl.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/usecases/get_local_games.dart';
import 'package:party_games_app/features/games/domain/usecases/get_published_games.dart';
import 'package:party_games_app/features/games/data/data_sources/local/app_database.dart';
import 'package:party_games_app/features/tasks/data/data_sources/testing/tasks_generator.dart';
import 'package:party_games_app/features/tasks/data/repository/task_repository_impl.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependenices() async {

  // database

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  sl.registerSingleton<AppDatabase>(database);


  // repositories

  sl.registerSingleton<TasksGenerator>(TasksGenerator());
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl()));

  sl.registerSingleton<GamesGenerator>(GamesGenerator());
  sl.registerSingleton<GameRepository>(GameRepositoryImpl(sl()));


  // usecases

  sl.registerSingleton(GetLocalGamesUseCase(sl()));
  sl.registerSingleton(GetPublishedGamesUseCase(sl()));



}