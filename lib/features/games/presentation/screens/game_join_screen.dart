import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/presentation/session_runner/session_runner.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/params/username_params.dart';
import 'package:party_games_app/features/user_data/domain/usecases/validate_username.dart';

class GameJoinScreenArguments {
  final String inviteCode;

  const GameJoinScreenArguments({required this.inviteCode});
}

class GameJoinScreen extends StatefulWidget {
  const GameJoinScreen({super.key, this.inviteCode});

  final String? inviteCode;
  static const routeName = "/JoinGame";

  @override
  State<StatefulWidget> createState() => _GameJoinScreenState();
}

class _GameJoinScreenState extends State<GameJoinScreen>
    with TickerProviderStateMixin {
  static double controllerValue = 0;
  late final AnimationController controller;
  String username = "";
  String inviteCode = "";

  final SessionEngine _sessionEngine = GetIt.instance<SessionEngine>();
  final ValidateUsernameUseCase _validateUsernameUseCase =
      GetIt.instance<ValidateUsernameUseCase>();

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
                    color: Colors.white,
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
              width: 220,
              onPressed: () =>
                  showMessage(context, "В данный момент камера недоступна.")),
          const SizedBox(
            height: kPadding,
          ),
          CustomButton(
              text: "Присоединиться по id", width: 220, onPressed: onJoinById),
          const SizedBox(
            height: kPadding,
          ),
          CustomButton(
              text: "Выйти",
              width: 220,
              onPressed: () => Navigator.of(context).pop())
        ]));
  }

  void onJoinById() {
    showWidget(context,
        content: Column(
          children: [
            SingleLineInputLabel(
                initialText: inviteCode,
                labelText: "id сессии",
                onSubmitted: (code) async {
                  inviteCode = code;
                  return SubmitResult.empty;
                }),
            const SizedBox(
              height: kPadding,
            ),
            SingleLineInputLabel(
                initialText: username,
                labelText: "Ваш никнейм",
                onSubmitted: onSubmittedUsername),
            const SizedBox(
              height: kPadding,
            ),
            CustomButton(text: "Присоединиться", onPressed: joinGame)
          ],
        ));
  }

  Future joinGame() async {
    var runner = SessionRunner(sessionEngine: _sessionEngine);
    runner.joinExistingGame(context,
        inviteCode: inviteCode, username: Username(username: username));
  }

  Future<SubmitResult> onSubmittedUsername(String username) async {
    bool isValid = await _validateUsernameUseCase.call(
        params: UsernameParams(username: Username(username: username)));

    if (isValid) {
      this.username = username;
      return SubmitResult.success;
    }
    await Future.microtask(() =>
        showMessage(context, ValidateUsernameUseCase.nicknameRequirements));
    return SubmitResult.error;
  }
}
