import 'package:get_it/get_it.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/game_sessions/data/data_sources/local/local_datasource.dart';
import 'package:party_games_app/features/game_sessions/data/engine/session_engine_impl.dart';
import 'package:party_games_app/features/game_sessions/data/engine/session_engine_test.dart';
import 'package:party_games_app/features/game_sessions/data/repository/session_data_repository_impl.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/repository/session_data_repository.dart';
import 'package:party_games_app/features/game_sessions/domain/usecases/get_sid.dart';
import 'package:party_games_app/features/games/data/data_sources/testing/games_generator.dart';
import 'package:party_games_app/features/games/data/repository/game_repository_impl.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/repository/remote_games_source.dart';
import 'package:party_games_app/features/games/domain/usecases/delete_game.dart';
import 'package:party_games_app/features/games/domain/usecases/get_local_games.dart';
import 'package:party_games_app/features/games/domain/usecases/get_local_games_sorted.dart';
import 'package:party_games_app/features/games/domain/usecases/get_published_games.dart';
import 'package:party_games_app/features/games/domain/usecases/save_game.dart';
import 'package:party_games_app/features/games/domain/usecases/update_game.dart';
import 'package:party_games_app/features/tasks/data/data_sources/testing/tasks_generator.dart';
import 'package:party_games_app/features/tasks/data/repository/task_repository_impl.dart';
import 'package:party_games_app/features/tasks/domain/repository/remote_tasks_source.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';
import 'package:party_games_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_local_tasks.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_local_tasks_sorted.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_published_tasks.dart';
import 'package:party_games_app/features/tasks/domain/usecases/save_task.dart';
import 'package:party_games_app/features/tasks/domain/usecases/update_task.dart';
import 'package:party_games_app/features/user_data/data/data_sources/local/local_datasource.dart';
import 'package:party_games_app/features/user_data/data/repository/user_data_repository_impl.dart';
import 'package:party_games_app/features/user_data/domain/repository/user_data_repository.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_uid.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/save_username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/validate_username.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependenices() async {
  // database
  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  // SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // repositories
  //   userdata
  sl.registerSingleton(LocalUsernameDatasource(sl()));
  sl.registerSingleton<UsernameRepository>(UsernameRepositoryImpl(sl()));
  sl.registerSingleton(GetUIDUseCase(sl()));
  //   session
  sl.registerSingleton(LocalSessionDatasource(sl()));
  sl.registerSingleton<SessionRepository>(SessionRepositoryImpl(sl()));
  sl.registerSingleton(GetSIDUseCase(sl()));
  //   tasks
  //sl.registerSingleton<RemoteTasksDataSource>(RestTaskDatabase(sl()));
  sl.registerSingleton<RemoteTasksDataSource>(TasksGenerator());
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl(), sl()));
  //   games
  //sl.registerSingleton<RemoteGamesDataSource>(RestGameDatabase(sl()));
  sl.registerSingleton<RemoteGamesDataSource>(GamesGenerator());
  sl.registerSingleton<GameRepository>(GameRepositoryImpl(sl(), sl(), sl()));

  // usecases

  //   games
  sl.registerSingleton(GetPublishedGamesUseCase(sl()));
  sl.registerSingleton(GetLocalGamesUseCase(sl()));
  sl.registerSingleton(GetLocalGamesSortedUseCase(sl()));
  sl.registerSingleton(SaveGameUseCase(sl()));
  sl.registerSingleton(UpdateGameUseCase(sl()));
  sl.registerSingleton(DeleteGameUseCase(sl()));

  //   tasks
  sl.registerSingleton(GetPublishedTasksUseCase(sl()));
  sl.registerSingleton(GetLocalTasksUseCase(sl()));
  sl.registerSingleton(GetLocalTasksSortedUseCase(sl()));
  sl.registerSingleton(SaveTaskUseCase(sl()));
  sl.registerSingleton(UpdateTaskUseCase(sl()));
  sl.registerSingleton(DeleteTaskUseCase(sl()));

  //   user_data
  sl.registerSingleton(GetUsernameUseCase(sl()));
  sl.registerSingleton(SaveUsernameUseCase(sl()));
  sl.registerSingleton(ValidateUsernameUseCase());

  // engine
  final SessionEngine engine = SessionEngineImpl(sl(),sl());
  // final SessionEngine engine = SessionEngineTestImpl();
  sl.registerSingleton<SessionEngine>(engine);
}
