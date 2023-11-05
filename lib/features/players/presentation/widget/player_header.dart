import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/features/players/domain/entities/player.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({super.key, required this.player});

  final PlayerEntity player;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: kBorderRadius, color: kAppBarColor),
      height: 60,
      padding: const EdgeInsets.all(kPadding / 2),
      margin: const EdgeInsets.symmetric(vertical: kPadding / 2),
      child: Row(children: [
        Image.network(player.photoUrl ?? "TO DO"),
        const SizedBox(
          width: kPadding,
        ),
        Text(
          player.name ?? "Unnamed",
          style: defaultTextStyle(fontSize: 20),
        ),
      ]),
    );
  }
}
