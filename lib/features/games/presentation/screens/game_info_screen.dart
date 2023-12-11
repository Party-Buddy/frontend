import 'package:flutter/cupertino.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/image_widget.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/tasks/presentation/screens/task_info_screen.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_header.dart';

class GameInfoScreenArguments {
  final Game game;

  GameInfoScreenArguments({required this.game});
}

class GameInfoScreen extends StatelessWidget {
  const GameInfoScreen({super.key, required this.game});

  static const routeName = "/GameInfo";

  final Game game;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Описание игры",
        showBackButton: true,
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (game.imageUri != null)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: kPadding).add(kPaddingAll),
                  child: BorderWrapper(
                      shadow: true,
                      child: ImageWidget(
                        url: game.imageUri!,
                        width: 200,
                        height: 200,
                      )),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderWrapper(
                        child: Text(
                      "Название",
                      style: defaultTextStyle(fontSize: 20),
                    )),
                    BorderWrapper(
                        borderColor: kPrimaryColor,
                        child: Text(
                          game.name,
                          style: defaultTextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: kPadding,
              ),
              if (game.description != null)
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: kPadding),
                  child: BorderWrapper(
                      child: Text(
                    game.description!,
                    style: defaultTextStyle(),
                  )),
                ),
              Container(
                margin:
                    kPaddingAll.add(const EdgeInsets.only(bottom: kPadding)),
                width: double.infinity,
                height: 1,
                color: kPrimaryColor,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
                alignment: Alignment.center,
                child: BorderWrapper(
                    child: Text(
                  "Список заданий",
                  style: defaultTextStyle(fontSize: 20),
                )),
              ),
              const SizedBox(
                height: kPadding,
              ),
              Column(
                children: game.tasks
                    .map((task) => Padding(
                          padding: const EdgeInsets.all(kPadding / 2),
                          child: TaskHeader(
                              task: task,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, TaskInfoScreen.routeName,
                                    arguments:
                                        TaskInfoScreenArguments(task: task));
                              }),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              CustomButton(
                  text: "Закрыть", onPressed: () => Navigator.of(context).pop()),
              const SizedBox(
                height: kPadding * 2,
              ),
            ],
          ),
        ));
  }
}
