import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/future_builder_wrapper.dart';
import 'package:party_games_app/features/games/presentation/screens/qr_scaner_screen.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/presentation/session_runner/session_runner.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_username.dart';
import 'package:party_games_app/features/user_data/domain/usecases/params/username_params.dart';
import 'package:party_games_app/features/user_data/domain/usecases/save_username.dart';
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
  final SaveUsernameUseCase _saveUsernameUseCase =
      GetIt.instance<SaveUsernameUseCase>();
  final GetUsernameUseCase _getUsernameUseCase =
      GetIt.instance<GetUsernameUseCase>();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
        value: controllerValue);
    controller.repeat();
    inviteCode = widget.inviteCode ?? "";
    if (inviteCode != "") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onJoinById();
      });
    }
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
              onPressed: onScanQR),
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

  void onScanQR() {
    Navigator.pushNamed(context, QRScannerScreen.routeName);
    // showMessage(context, "В данный момент камера недоступна.");
  }

  void onJoinById() {
    showWidget(context,
        content: Column(
          children: [
            SingleLineInputLabel(
                initialText: widget.inviteCode ?? "",
                labelText: "id сессии",
                onSubmitted: (code) async {
                  inviteCode = code;
                  return SubmitResult.empty;
                }),
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
                                onSubmitted: onSubmittedUsername);
                          },
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
      await _saveUsernameUseCase.call(
          params: UsernameParams(username: Username(username: username)));
      this.username = username;
      return SubmitResult.success;
    }
    await Future.microtask(() =>
        showMessage(context, ValidateUsernameUseCase.nicknameRequirements));
    return SubmitResult.error;
  }
}
