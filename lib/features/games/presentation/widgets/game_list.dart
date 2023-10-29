import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/option_switcher.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:toggle_switch/toggle_switch.dart';

class GameList extends StatefulWidget {
  const GameList({super.key, required this.onTapOnGame});

  final void Function(Game) onTapOnGame;

  @override
  State<StatefulWidget> createState() => _GameListState();
}

enum GameType { owned, public }

class _GameListState extends State<GameList> {
  GameType gameType = GameType.owned;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OptionSwitcher<GameType>(
        options: GameType.values, 
        onTap: (t) => setState(() => gameType = t), 
        initialOption: gameType,
        stringMapper: (t) => t == GameType.owned ? "Ваши" : "Публичные",
      ),
    ]);
  }
}
