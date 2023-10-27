import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/button.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgorundColor,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: kBackgroundGradient),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Lottie.network(
                    // disco-ball
                    'https://lottie.host/ad9af4da-373b-4d91-8e57-70033d74e943/LgkIlgzRJg.json',
                  ),
                ),
                Expanded(
                  child: Lottie.network(
                    // dancing haires
                    'https://lottie.host/f273e7ef-deaa-4928-bb62-d745829aa6d1/BtzodHU8c2.json',
                  ),
                ),
                Expanded(
                  child: Column(children: [
                    CustomButton(
                        text: "Создать игру",
                        onPressed: () =>
                            Navigator.pushNamed(context, "/CreateGame")),
                    const SizedBox(
                      height: kPadding,
                    ),
                    CustomButton(
                        text: "Присоединиться",
                        onPressed: () =>
                            Navigator.pushNamed(context, "/JoinGame"))
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
