import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_check_box.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/players/domain/entities/player.dart';
import 'package:party_games_app/features/players/presentation/widget/player_header.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GameSessionEntity {
  final String sessionID;
  final int playersCount;

  const GameSessionEntity(
      {required this.sessionID, required this.playersCount});
}

const gameSessionMock = GameSessionEntity(sessionID: "AB89K3", playersCount: 4);
const playersMock = [
  PlayerEntity(
      id: 1,
      name: "Alex",
      photoUrl:
          "https://gravatar.com/avatar/f79cc32d7f9cee4a094d1b1772c56d1c?s=400&d=robohash&r=x"),
  PlayerEntity(
      id: 2,
      name: "James",
      photoUrl:
          "https://robohash.org/f79cc32d7f9cee4a094d1b1772c56d1c?set=set4&bgset=&size=400x400"),
  PlayerEntity(
      id: 3,
      name: "Сладкая Дыня",
      photoUrl:
          "https://robohash.org/63704034a6c7a8ce2ed2b9007faededa?set=set4&bgset=&size=400x400"),
];

class WaitingRoomScreenArguments {
  final GameSessionEntity gameSession;
  final List<PlayerEntity> players;

  const WaitingRoomScreenArguments(
      {required this.players, required this.gameSession});
}

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen(
      {super.key, required this.players, required this.gameSession});

  final GameSessionEntity gameSession;
  final List<PlayerEntity> players;

  static const routeName = "/WaitingRoom";

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
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
                        "Подключилось ${widget.players.length}/${widget.gameSession.playersCount} игроков",
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
                      children: widget.players
                          .map((p) => PlayerHeader(player: p))
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
                          widget.gameSession.sessionID,
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
                            ClipboardData(text: widget.gameSession.sessionID)),
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
                      CustomCheckBox(enabledNotifier: ValueNotifier(false),) //TODO: replace with appropriate notifier
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CustomButton(
                    text: "Показать QR",
                    onPressed: () =>
                        showWidget(context, content: buildQRWidget())),
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
        ));
  }

  Widget buildQRWidget() {
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
              child: QrImageView(data: widget.gameSession.sessionID)),
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
