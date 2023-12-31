import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/image_widget.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_player.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader(
      {super.key,
      required this.player,
      this.highlight = false,
      this.isWinner = false,
      this.points});

  final GamePlayer player;
  static const defaultPhotoUrl =
      "https://cdn.icon-icons.com/icons2/1371/PNG/512/batman_90804.png";
  static const defaultPlayerName = "Игрок";
  final bool highlight;
  final bool isWinner;
  final int? points;

  BoxBorder? getBorder() {
    if (highlight) {
      return Border.all(color: kPrimaryColor);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: isWinner ? lighten(kAppBarColor, .05) : kAppBarColor,
          border: highlight ? Border.all(color: kPrimaryColor, width: 2) : null,
          boxShadow: isWinner
              ? []
              : []),
      height: 60,
      padding: const EdgeInsets.all(kPadding / 2),
      margin: const EdgeInsets.symmetric(vertical: kPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            ImageWidget(
              url: player.photoUrl ?? defaultPhotoUrl,
              height: 40,
              width: 40,
            ),
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
          Row(
            children: [
              isWinner
                  ? Image.network(
                      'https://cdn-icons-png.flaticon.com/512/3750/3750043.png',
                      height: 40,
                    )
                  : Container(),
              points != null
                  ? Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(
                        points!.toString(),
                        style: defaultTextStyle(
                            fontSize: 20,
                            color: isWinner ? Colors.yellow : kFontColor),
                      ))
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
