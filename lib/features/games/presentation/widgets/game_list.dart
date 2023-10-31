import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/widgets/future_builder_wrapper.dart';
import 'package:party_games_app/core/widgets/option_switcher.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/usecases/get_local_games.dart';
import 'package:party_games_app/features/games/domain/usecases/get_published_games.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_header.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../tasks/domain/entities/task.dart';

class GameList extends StatefulWidget {
  

  const GameList({super.key, required this.onTapOnGame});

  final void Function(Game) onTapOnGame;

  @override
  State<StatefulWidget> createState() => _GameListState();
}

enum GameType { owned, public }

class _GameListState extends State<GameList> {
  GameType gameType = GameType.owned;

  final GetLocalGamesUseCase _getLocalGamesUseCase = GetIt.instance<GetLocalGamesUseCase>();
  final GetPublishedGamesUseCase _getPublishedGamesUseCase = GetIt.instance<GetPublishedGamesUseCase>();

  Future<DataState<List<Game>>> convertFuture(Future<List<Game>> future) async {
    return future.then((list) {
      return DataSuccess<List<Game>>(list);
    });
  }

  Future<DataState<List<Game>>> convertFutureDataState(Future<DataState<List<Game>>> future) async {
    return future.then((list) {
      return list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OptionSwitcher<GameType>(
        options: GameType.values,
        onTap: (t) => setState(() => gameType = t),
        initialOption: gameType,
        stringMapper: (t) => t == GameType.owned ? "Ваши" : "Публичные",
      ),
      const SizedBox(
        height: kPadding,
      ),
      FutureBuilderWrapper(
          future: gameType == GameType.public ? convertFuture(_getLocalGamesUseCase.call()) : convertFutureDataState(_getPublishedGamesUseCase.call()),
          notFoundWidget: () => Container(), // TO DO: handle errors
          builder: (data) {
            if (data.error != null) {
              return Container(); // TO DO: handle errors
            }
            return SingleChildScrollView(
              child: Column(
                children: data.data!
                    .map((game) => Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: kPadding / 2),
                        child: InkWell(
                            onTap: () => widget.onTapOnGame(game),
                            child: GameHeader(game: game))))
                    .toList(),
              ),
            );
          })
    ]);
  }

}
