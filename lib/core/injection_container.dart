import 'package:get_it/get_it.dart';
import 'package:party_games_app/features/tasks/data/data_sources/testing/tasks_generator.dart';import 'package:party_games_app/features/tasks/data/repository/task_repository_impl.dart';import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';final sl = GetIt.instance;

Future<void> initializeDependenices() async {
  sl.registerSingleton<TasksGenerator>(TasksGenerator());
  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl()));
}