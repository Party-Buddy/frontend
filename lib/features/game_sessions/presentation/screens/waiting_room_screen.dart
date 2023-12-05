import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_check_box.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/games/presentation/widgets/player_header.dart';
import 'package:qr_flutter/qr_flutter.dart';

var gameSessionMock = GameSession(
    sessionId: "AB89K3",
    name: '',
    description: '',
    tasks: [],
    maxPlayersCount: 4,
    players: [
      const GamePlayer(
          id: 1,
          ready: false,
          name: "Alex",
          photoUrl:
              "https://gravatar.com/avatar/f79cc32d7f9cee4a094d1b1772c56d1c?s=400&d=robohash&r=x"),
      const GamePlayer(
          id: 2,
          ready: false,
          name: "James",
          photoUrl:
              "https://robohash.org/f79cc32d7f9cee4a094d1b1772c56d1c?set=set4&bgset=&size=400x400"),
      const GamePlayer(
          id: 3,
          ready: true,
          name: "Сладкая Дыня",
          photoUrl:
              "https://robohash.org/63704034a6c7a8ce2ed2b9007faededa?set=set4&bgset=&size=400x400"),
    ]);

class WaitingRoomScreenArguments {
  final ValueNotifier<GameSession> gameSession;
  final SessionEngine sessionEngine;

  const WaitingRoomScreenArguments(
      {required this.gameSession, required this.sessionEngine});
}

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen(
      {super.key, required this.gameSession, required this.sessionEngine});

  final ValueNotifier<GameSession> gameSession;
  final SessionEngine sessionEngine;

  static const routeName = "/WaitingRoom";

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  final readyNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    readyNotifier.addListener(onReadyChanged);
  }

  @override
  void dispose() {
    readyNotifier.removeListener(onReadyChanged);
    super.dispose();
  }

  void onReadyChanged() {
    widget.sessionEngine.setReady(readyNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.gameSession,
      builder: (context, gameSession, child) => BaseScreen(
          appBarTitle: "Ожидание игроков",
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Подключилось ${gameSession.players.length}/${gameSession.maxPlayersCount} игроков",
                          style: defaultTextStyle(fontSize: 20),
                        ),
                        const CircularProgressIndicator(
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kPadding,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: gameSession.players
                            .map((p) => PlayerHeader(
                                  player: p,
                                  highlight:
                                      gameSession.currentPlayerId == p.id,
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: kPadding,
                    ),
                    Row(
                      children: [
                        Text(
                          "Код сессии:",
                          style: defaultTextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: kPadding,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: kAppBarColor, borderRadius: kBorderRadius),
                          padding: const EdgeInsets.all(kPadding / 2),
                          child: SelectableText(
                            gameSession.sessionId,
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontFamily: "Roboto",
                                fontSize: 24),
                          ),
                        ),
                        const SizedBox(
                          width: kPadding,
                        ),
                        CustomIconButton(
                          onPressed: () => Clipboard.setData(
                              ClipboardData(text: gameSession.sessionId)),
                          iconData: Icons.link,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kPadding * 1.5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Готовность:",
                          style: defaultTextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: kPadding * 1.5,
                        ),
                        CustomCheckBox(
                          enabledNotifier: readyNotifier,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CustomButton(
                      text: "Показать QR",
                      onPressed: () => showWidget(context,
                          content: buildQRWidget(gameSession.sessionId))),
                  const SizedBox(
                    height: kPadding,
                  ),
                  CustomButton(
                      text: "Покинуть игру",
                      onPressed: () => showConfirmationDialog(context,
                          text: "Вы точно хотите выйти?",
                          onConfirmed: () => Navigator.pushNamed(
                              context, MainMenuScreen.routeName))),
                ],
              )
            ],
          )),
    );
  }

  Widget buildQRWidget(String sessionId) {
    return SizedBox(
      width: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 230,
              width: 230,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: kBorderRadius),
              child: QrImageView(data: sessionId)),
          const SizedBox(
            height: kPadding,
          ),
          Container(
            width: 230,
            alignment: Alignment.center,
            child: Text(
              "Просканируйте для присоединения",
              textAlign: TextAlign.center,
              style: defaultTextStyle(),
            ),
          )
        ],
      ),
    );
  }
}
