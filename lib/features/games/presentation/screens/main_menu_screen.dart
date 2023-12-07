import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/constructor/presentation/screens/constructor_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_join_screen.dart';
import 'package:party_games_app/features/games/presentation/screens/game_start_screen.dart';
import 'package:party_games_app/tests_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  static const routeName = "/";

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Lottie.network(
              // disco-ball
              'https://lottie.host/ad9af4da-373b-4d91-8e57-70033d74e943/LgkIlgzRJg.json',
            ),
          ),
          Expanded(
            // child: Container(
            //   alignment: Alignment.topCenter,
            //   child: SizedBox(width: 250, child: Image.asset("assets/images/logo.png")),
            // ),
            child: Lottie.network(
                // dancing haires
                'https://lottie.host/f273e7ef-deaa-4928-bb62-d745829aa6d1/BtzodHU8c2.json'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(kPadding * 2),
              child: Column(children: [
                CustomButton(
                    text: "Начать игру",
                    onPressed: () => Navigator.pushNamed(context, GameStartScreen.routeName)),
                const SizedBox(
                  height: kPadding,
                ),
                CustomButton(
                    text: "Присоединиться",
                    onPressed: () => Navigator.pushNamed(context, GameJoinScreen.routeName)),
                const SizedBox(
                  height: kPadding,
                ),
                CustomButton(
                    text: "Конструктор",
                    onPressed: () => Navigator.pushNamed(context, ConstructorScreen.routeName)),
                const SizedBox(
                  height: kPadding,
                ),
                CustomButton(text: "Тест экранов", onPressed: () => Navigator.pushNamed(context, TestsScreen.routeName))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
