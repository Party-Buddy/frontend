import 'package:flutter/material.dart';
import 'package:party_games_app/features/games/presentation/screens/game_start_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_join_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const MainMenuScreen());

      case '/CreateGame':
        return _materialRoute(const GameStartScreen());

      case '/JoinGame':
        return _materialRoute(const GameJoinScreen());

      default:
        return _materialRoute(const MainMenuScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
