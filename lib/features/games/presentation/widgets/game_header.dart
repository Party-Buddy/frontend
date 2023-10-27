import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: kBorderRadius, border: border()),
        padding: kPaddingAll,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                borderWrapper(Text(
                  game.name,
                  style: const TextStyle(
                      fontFamily: kFontFamily, fontSize: 18, color: kFontColor),
                )),
                const SizedBox(
                  height: kPadding,
                ),
                borderWrapper(Text(
                  getTasksCountLabel(),
                  style: const TextStyle(
                      fontFamily: kFontFamily, fontSize: 16, color: kFontColor),
                )),
              ],
            ),
            ClipRRect(
              borderRadius: kBorderRadius,
              child: Image.network(
                game.photoUrl ?? "TO DO",
                height: 90,
              ),
            )
          ],
        ));
  }

  String getTasksCountLabel() {
    String? postfix;
    String strCount = game.tasks.length.toString();

    if (strCount.endsWith("1") && !strCount.endsWith("11")) postfix = "задание";
    if (strCount.endsWith("2") && !strCount.endsWith("12")) postfix = "задания";
    if (strCount.endsWith("3") && !strCount.endsWith("13")) postfix = "задания";
    if (strCount.endsWith("4") && !strCount.endsWith("14")) postfix = "задания";

    return "$strCount ${postfix ?? "заданий"}";
  }
}
