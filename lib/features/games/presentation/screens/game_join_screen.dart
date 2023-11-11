import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';

class GameJoinScreen extends StatefulWidget {
  const GameJoinScreen({super.key});

  static const routeName = "/JoinGame";

  @override
  State<StatefulWidget> createState() => _GameJoinScreenState();
}

class _GameJoinScreenState extends State<GameJoinScreen>
    with TickerProviderStateMixin {
  static double controllerValue = 0;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
        value: controllerValue);
    controller.repeat();
  }

  @override
  void dispose() {
    controllerValue = controller.value;
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Присоединиться к игре",
        content: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: kPaddingAll,
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
              Lottie.network(
                  'https://lottie.host/808f95d0-715b-4340-a212-694470efa19c/FL2CLCdShE.json',
                  width: 300,
                  height: 300,
                  controller: controller,
                  frameRate: FrameRate(60.0))
            ],
          ),
          const SizedBox(
            height: kPadding,
          ),
          CustomButton(
              text: "Сканировать QR",
              onPressed: () => showMessage(context,
                  "Тут должна будет открыться камера для сканирования 🙂")),
        ]));
  }
}

// https://lottie.host/808f95d0-715b-4340-a212-694470efa19c/FL2CLCdShE.json