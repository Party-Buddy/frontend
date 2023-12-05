import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({super.key, required this.player, this.highlight = false});

  final GamePlayer player;
  static const defaultPhotoUrl =
      "https://cdn.icon-icons.com/icons2/1371/PNG/512/batman_90804.png";
  static const defaultPlayerName = "Игрок";
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: kAppBarColor,
          border: highlight ? Border.all(color: kPrimaryColor) : null),
      height: 60,
      padding: const EdgeInsets.all(kPadding / 2),
      margin: const EdgeInsets.symmetric(vertical: kPadding / 2),
      child: Row(children: [
        Image.network(player.photoUrl ?? defaultPhotoUrl),
        const SizedBox(
          width: kPadding,
        ),
        Text(
          player.name == null
              ? defaultPlayerName
              : player.name!.isEmpty
                  ? defaultPlayerName
                  : player.name!,
          style: defaultTextStyle(fontSize: 20),
        ),
      ]),
    );
  }
}
