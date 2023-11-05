import 'package:flutter/material.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

class GameHeader extends StatefulWidget {
  const GameHeader({super.key, required this.game, required this.onTap});

  final Game game;
  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => _GameHeaderState();
}

class _GameHeaderState extends State<GameHeader> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (h) => setState(() => _hovered = h),
      child: BorderWrapper(
          fillColor: _hovered ? kPrimaryDarkColor.withOpacity(.3) : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(kPadding / 2),
                    child: Text(
                      widget.game.name,
                      style: const TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 18,
                          color: kFontColor),
                    ),
                  ),
                  const SizedBox(
                    height: kPadding,
                  ),
                  Container(
                    padding: const EdgeInsets.all(kPadding / 2),
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
              Image.network(
                widget.game.imageUri ?? "TO DO",
                height: 90,
              ),
            ],
          )),
    );
  }

  String getTasksCountLabel() {
    String? postfix;
    String strCount = widget.game.tasks.length.toString();

    if (strCount.endsWith("1") && !strCount.endsWith("11")) postfix = "задание";
    if (strCount.endsWith("2") && !strCount.endsWith("12")) postfix = "задания";
    if (strCount.endsWith("3") && !strCount.endsWith("13")) postfix = "задания";
    if (strCount.endsWith("4") && !strCount.endsWith("14")) postfix = "задания";

    return "$strCount ${postfix ?? "заданий"}";
  }
}
