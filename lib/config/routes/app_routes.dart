import 'package:flutter/material.dart';
import 'package:party_games_app/features/games/presentation/screens/qr_scaner_screen.dart';
import 'package:party_games_app/features/constructor/presentation/screens/constructor_screen.dart';
import 'package:party_games_app/features/constructor/presentation/screens/game_create_screen.dart';
import 'package:party_games_app/features/constructor/presentation/screens/task_create_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/game_results_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_results_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/voting_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/waiting_room_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_info_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_start_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_join_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/tasks/presentation/screens/task_info_screen.dart';
import 'package:party_games_app/tests_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MainMenuScreen.routeName:
        return _materialRoute(const MainMenuScreen());

      case GameStartScreen.routeName:
        return _materialRoute(const GameStartScreen());

      case GameJoinScreen.routeName:
        {
          if (settings.arguments != null) {
            final args = settings.arguments as GameJoinScreenArguments;

            return _materialRoute(GameJoinScreen(inviteCode: args.inviteCode));
          } else {
            return _materialRoute(const GameJoinScreen());
          }
        }
      case ConstructorScreen.routeName:
        return _materialRoute(ConstructorScreen());

      case GameCreateScreen.routeName:
        return _materialRoute(const GameCreateScreen());

      case TaskCreateScreen.routeName:
        return _materialRoute(const TaskCreateScreen());

      case QRScannerScreen.routeName:
        return _materialRoute(const QRScannerScreen());

      case TestsScreen.routeName:
        return _materialRoute(const TestsScreen());

      case WaitingRoomScreen.routeName:
        {
          final args = settings.arguments as WaitingRoomScreenArguments;

          return _materialRoute(WaitingRoomScreen(
            gameSession: args.gameSession,
            sessionEngine: args.sessionEngine,
          ));
        }

      case VotingScreen.routeName:
        {
          final args = settings.arguments as VotingScreenArguments;

          return _materialRoute(VotingScreen(
              sessionEngine: args.sessionEngine,
              pollInfo: args.pollInfo,
              taskInfo: args.taskInfo,
              gameName: args.gameName,
              tasksCount: args.tasksCount));
        }

      case GameInfoScreen.routeName:
        {
          final args = settings.arguments as GameInfoScreenArguments;

          return _materialRoute(GameInfoScreen(game: args.game));
        }

      case TaskInfoScreen.routeName:
        {
          final args = settings.arguments as TaskInfoScreenArguments;

          return _materialRoute(TaskInfoScreen(task: args.task));
        }

      case GameResultsScreen.routeName:
        {
          final args = settings.arguments as GameResultsScreenArguments;

          return _materialRoute(GameResultsScreen(
            gameResults: args.gameResults,
            players: args.players,
            gameName: args.gameName,
          ));
        }

      case TaskResultsScreen.routeName:
        {
          final args = settings.arguments as TaskResultsScreenArguments;

          return _materialRoute(TaskResultsScreen(
            sessionEngine: args.sessionEngine,
            taskResults: args.taskResults,
            taskInfo: args.taskInfo,
            tasksCount: args.tasksCount,
            players: args.players,
            gameName: args.gameName,
          ));
        }
      case TaskScreen.routeName:
        {
          final args = settings.arguments as TaskScreenArguments;

          return _materialRoute(TaskScreen(
            taskInfo: args.taskInfo,
            currentTask: args.currentTask,
            sessionEngine: args.sessionEngine,
            tasksCount: args.tasksCount,
          ));
        }

      default:
        return _materialRoute(const MainMenuScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
