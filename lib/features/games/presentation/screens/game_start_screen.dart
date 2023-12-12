import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:party_games_app/config/consts.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/future_builder_wrapper.dart';
import 'package:party_games_app/core/widgets/labeled_slider.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/presentation/session_runner/session_runner.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_list.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_header.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/params/username_params.dart';
import 'package:party_games_app/features/user_data/domain/usecases/save_username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/validate_username.dart';

class GameStartScreen extends StatefulWidget {
  const GameStartScreen({super.key});

  static const routeName = "/GameStart";

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  Game game = PublishedGame(
      id: '11112222-3333-4444-5555-131072262144',
      name: "Minecraft",
      imageUri:
          "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
      tasks: [
        PublishedCheckedTextTask(
            id: '12345678-1234-1234-1234-123456789abc',
            name: "Basics1",
            description: "what is the max stack size for swords?",
            duration: 10,
            answer: "1"),
      ],
      updatedAt: DateTime.now());

  final SessionEngine _sessionEngine = GetIt.instance<SessionEngine>();
  final ValidateUsernameUseCase _validateUsernameUseCase =
      GetIt.instance<ValidateUsernameUseCase>();
  final SaveUsernameUseCase _saveUsernameUseCase =
      GetIt.instance<SaveUsernameUseCase>();
  final GetUsernameUseCase _getUsernameUseCase =
      GetIt.instance<GetUsernameUseCase>();

  String username = "";
  int maxPlayersCount = minPossiblePlayersCount;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBarTitle: "Начать игру",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: kPadding,
              ),
              Row(
                children: [
                  Flexible(
                    child: username.isEmpty
                        ? FutureBuilderWrapper(
                            delayRatio: 0,
                            future: _getUsernameUseCase.call(),
                            notFoundWidget: () => const SizedBox(),
                            builder: (username) {
                              this.username = username.username;
                              return SingleLineInputLabel(
                                initialText: username.username,
                                labelText: "Ваш никнейм",
                                onSubmitted: onSubmittedUsername);},
                          )
                        : SingleLineInputLabel(
                            initialText: username,
                            labelText: "Ваш никнейм",
                            onSubmitted: onSubmittedUsername),
                  ),
                  const SizedBox(
                    width: kPadding,
                  ),
                  BorderWrapper(
                    padding: kPadding * 1.35,
                    child: Icon(
                      Icons.person_2,
                      size: 30,
                      color: kBorderColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              GameHeader(
                game: game,
                onTap: () => showWidget(context,
                    content: GameList(
                        onTapOnGame: (selectedGame) => setState(() {
                              Navigator.pop(context);
                              game = selectedGame;
                            }))),
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              BorderWrapper(
                  child: LabeledSlider(
                      min: minPossiblePlayersCount,
                      max: maxPossiblePlayersCount,
                      initial: maxPlayersCount,
                      onChanged: (newPlayersCount) =>
                          maxPlayersCount = newPlayersCount,
                      displayValue: (playersCount) =>
                          "Количество игроков: $playersCount")),
            ],
          ),
          Column(
            children: [
              CustomButton(text: "Продолжить", onPressed: onGameStart),
              const SizedBox(
                height: kPadding,
              ),
              CustomButton(
                  text: "Выйти",
                  onPressed: () => Navigator.pushNamed(context, "/"))
            ],
          )
        ],
      ),
    );
  }

  Future<SubmitResult> onSubmittedUsername(String username) async {
    bool isValid = await _validateUsernameUseCase.call(
        params: UsernameParams(username: Username(username: username)));

    if (isValid) {
      await _saveUsernameUseCase.call(
          params: UsernameParams(username: Username(username: username)));
      this.username = username;
      return SubmitResult.success;
    }
    await Future.microtask(() =>
        showMessage(context, ValidateUsernameUseCase.nicknameRequirements));
    return SubmitResult.error;
  }

  void onGameStart() async {

    var runner = SessionRunner(sessionEngine: _sessionEngine);
    runner.runNewGame(context,
        game: game,
        maxPlayersCount: maxPlayersCount,
        username: Username(username: username));
  }
}
