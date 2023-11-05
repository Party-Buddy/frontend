import 'package:flutter/material.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/features/players/domain/entities/player.dart';

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

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen(
      {super.key, required this.players, required this.gameSession});

  final GameSessionEntity gameSession;
  final List<PlayerEntity> players;

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(content: Container());
  }
}
