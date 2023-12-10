import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/image_network.dart';
import 'package:party_games_app/core/widgets/inkwell_border_wrapper.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key, required this.game, required this.onTap});

  final Game game;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkwellBorderWrapper(
        onPressed: onTap,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BorderWrapper(
                    fillColor: lighten(kAppBarColor, .1),
                    child: Text(
                      game.name,
                      style: const TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 18,
                          color: kFontColor),
                    ),
                  ),
                  const SizedBox(
                    height: kPadding / 2,
                  ),
                  BorderWrapper(
                    fillColor: lighten(kAppBarColor, .1),
                    child: Text(
                      getTasksCountLabel(),
                      style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 16,
                          color: kFontColor.withOpacity(.9)),
                    ),
                  )
                ],
              ),
              game.imageUri != null
                  ? (game.imageUri!.startsWith('http')
                      ? ImageNetwork(url: game.imageUri!, height: 90, width: 90)
                      : Image.file(File(game.imageUri!), height: 90))
                  : const Image(
                      image: AssetImage('assets/images/no-photo.png'),
                      height: 90)
            ]));
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
