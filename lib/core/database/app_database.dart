import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/DAO/game_dao.dart';
import 'package:party_games_app/features/games/data/data_sources/local/DAO/task_binding_dao.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/local_game.dart';
import 'package:party_games_app/features/games/data/data_sources/local/tables/task_binding.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/DAO/checked_text_task_dao.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/DAO/poll_task_dao.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/base_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/checked_text_task.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/tables/poll_task.dart';

part 'app_database.g.dart';

@UseMoor(tables: [LocalGames, BaseTasks, CheckedTextTasks, TaskBindings, PollTasks], daos: [GameDao, CheckedTextTaskDao, TaskBindingDao, PollTaskDao])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'app_database.db', logStatements: true));
  
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  );
}