import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/features/games/data/data_sources/local/DAO/game_dao.dart';
import 'package:party_games_app/features/games/data/data_sources/local/DAO/task_binding_dao.dart';
import 'package:party_games_app/features/games/data/models/local_game.dart';
import 'package:party_games_app/features/games/data/models/task_binding.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/DAO/checked_text_task_dao.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';
import 'package:party_games_app/features/tasks/data/models/local/checked_text_task.dart';

part 'app_database.g.dart';

@UseMoor(tables: [LocalGames, BaseTasks, CheckedTextTasks, TaskBindings], daos: [GameDao, CheckedTextTaskDao, TaskBindingDao])
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