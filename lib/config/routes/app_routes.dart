import 'package:flutter/material.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/waiting_room_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_start_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_join_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MainMenuScreen.routeName:
        return _materialRoute(const MainMenuScreen());

      case GameStartScreen.routeName:
        return _materialRoute(const GameStartScreen());

      case GameJoinScreen.routeName:
        return _materialRoute(const GameJoinScreen());

      case WaitingRoomScreen.routeName: {
        final args = settings.arguments as WaitingRoomScreenArguments;

        return _materialRoute(WaitingRoomScreen(players: args.players, gameSession: args.gameSession));
      }
      
      default:
        return _materialRoute(const MainMenuScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
