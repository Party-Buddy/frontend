import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/async/future.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/resources/source_enum.dart';
import 'package:party_games_app/core/widgets/future_builder_wrapper.dart';
import 'package:party_games_app/core/widgets/option_switcher.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/usecases/get_local_games.dart';
import 'package:party_games_app/features/games/domain/usecases/get_local_games_sorted.dart';
import 'package:party_games_app/features/games/domain/usecases/get_published_games.dart';
import 'package:party_games_app/features/games/domain/usecases/params/games_sort_params.dart';
import 'package:party_games_app/features/games/presentation/widgets/game_header.dart';

class GameList extends StatefulWidget {
  const GameList({super.key, required this.onTapOnGame});

  final void Function(Game) onTapOnGame;

  @override
  State<StatefulWidget> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  Source gameType = Source.owned;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OptionSwitcher<Source>(
        options: Source.values,
        onTap: (t) => setState(() => gameType = t),
        initialOption: gameType,
        stringMapper: (t) => t == Source.owned ? "Ваши" : "Публичные",
      ),
      const SizedBox(
        height: kPadding,
      ),
      buildGameList(context, onTapOnGame: widget.onTapOnGame, source: gameType)
    ]);
  }
}

final GetLocalGamesUseCase _getLocalGamesUseCase =
    GetIt.instance<GetLocalGamesUseCase>();
final GetLocalGamesSortedUseCase _getLocalGamesSortedUseCase =
    GetIt.instance<GetLocalGamesSortedUseCase>();
final GetPublishedGamesUseCase _getPublishedGamesUseCase =
    GetIt.instance<GetPublishedGamesUseCase>();

FutureBuilderWrapper<DataState<List<Game>>> buildGameList(BuildContext context,
    {required Function(Game) onTapOnGame,
    required Source source,
    GamesSortParams? params}) {
  return FutureBuilderWrapper(
      key: Key(source.name),
      future: source == Source.public
          ? convertFutureDataState(_getPublishedGamesUseCase.call())
          : params == null
              ? convertFuture(_getLocalGamesUseCase.call())
              : convertFuture(_getLocalGamesSortedUseCase.call(params: params)),
      notFoundWidget: () =>
          buildNotFoundWidget(text: "У вас пока нет своих игр"),
      builder: (data) {
        if (data.error != null) {
          showMessage(context, data.error!); // TO DO: handle errors
        }
        debugPrint(data.data!.toString());
        if (data.data!.isEmpty) {
          String text;
          if (source == Source.owned) {
            text = "У вас пока нет своих игр.";
          } else {
            text = "Игры из каталога на данный момент недоступны.";
          }
          return buildNotFoundWidget(text: text);
        }
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .6,
          ),
          padding: const EdgeInsets.only(bottom: kPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: kPadding),
            child: Column(
              children: data.data!
                  .map((game) => Padding(
                      padding: const EdgeInsets.all(kPadding / 2).add(
                          const EdgeInsets.symmetric(horizontal: kPadding / 2)),
                      child: GameHeader(
                          game: game, onTap: () => onTapOnGame(game))))
                  .toList(),
            ),
          ),
        );
      });
}

Widget buildNotFoundWidget({required String text}) {
  return Container(
    alignment: Alignment.center,
    padding: kPaddingAll,
    child: Text(
      text,
      style: defaultTextStyle(),
    ),
  );
}
