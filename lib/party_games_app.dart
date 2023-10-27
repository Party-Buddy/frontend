import 'package:flutter/material.dart';
import 'package:party_games_app/config/app_config.dart';
import 'package:party_games_app/config/routes/app_routes.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';

class PartyGamesApp extends StatelessWidget {
  const PartyGamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kTitle,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const MainMenuScreen(),
    );
  }
}
