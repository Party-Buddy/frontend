import 'package:floor/floor.dart';
import 'package:party_games_app/features/games/data/data_sources/local/DAO/game_dao.dart';
import 'package:party_games_app/features/games/data/data_sources/local/DAO/task_binding_dao.dart';
import 'package:party_games_app/features/games/data/models/local_game.dart';
import 'package:party_games_app/features/games/data/models/task_binding.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/DAO/base_task_dao.dart';
import 'package:party_games_app/features/tasks/data/data_sources/local/DAO/checked_text_task_dao.dart';
import 'package:party_games_app/features/tasks/data/models/local/base_task.dart';
import 'package:party_games_app/features/tasks/data/models/local/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [LocalGameModel, BaseTaskModel, CheckedTextTaskModel, TaskBinding])
abstract class AppDatabase extends FloorDatabase{

  BaseTaskDao get baseTaskDao;

  CheckedTextTaskDao get checkedTextTaskDao;
  
  LocalGameDao get gameDao;

  TaskBindingDao get taskBindingDao;

}