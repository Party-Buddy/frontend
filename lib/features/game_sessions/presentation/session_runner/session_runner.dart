import 'package:flutter/material.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/game_session.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/game_results_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_results_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/task_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/voting_screen.dart';
import 'package:party_games_app/features/game_sessions/presentation/screens/waiting_room_screen.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/presentation/screens/main_menu_screen.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:timer_count_down/timer_count_down.dart';

class SessionRunner {
  final SessionEngine sessionEngine;

  SessionRunner({required this.sessionEngine});

  Future runNewGame(BuildContext context,
      {required Game game,
      required int maxPlayersCount,
      required Username username}) async {
    _runGameSession(context,
        sessionIdFuture: sessionEngine.startSession(game, username,
            maxPlayersCount: maxPlayersCount));
  }

  Future joinExistingGame(BuildContext context,
      {required String inviteCode, required Username username}) async {
    _runGameSession(context,
        sessionIdFuture: sessionEngine.joinSession(inviteCode, username));
  }

  Future _runGameSession(BuildContext context,
      {required Future<DataState<String>> sessionIdFuture}) async {
    showWidget(
      context,
      content: Column(
        children: [
          Text(
            "Подключение к сессии",
            style: defaultTextStyle(),
          ),
          const SizedBox(
            height: kPadding,
          ),
          const CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ],
      ),
    );

    DataState<String> sessionId = await sessionIdFuture;

    debugPrint(sessionId.data);

    if (sessionId.error != null) {
      await Future.microtask(() {
        Navigator.pushNamed(context, MainMenuScreen.routeName);
        showMessage(context, sessionId.error!);
        });
      return;
    }

    bool sessionReceived = false;

    late ValueNotifier<GameSession> gameSession;
    sessionEngine.onGameStart((time) {
      if (time == null) return;

      showWidget(context,
          content: Countdown(
              seconds: DateTime.fromMillisecondsSinceEpoch(time)
                  .difference(DateTime.now())
                  .inSeconds,
              interval: const Duration(milliseconds: 100),
              build: (context, time) => time <= 0.0
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ))
                  : Column(
                      children: [
                        Text(
                          "Игра начинается через",
                          style: defaultTextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          height: kPadding,
                        ),
                        Text(
                          "$time",
                          style: defaultTextStyle(
                              fontSize: 26, color: kPrimaryColor),
                        ),
                      ],
                    )));
    });

    sessionEngine.onGameStatus((newGameSessionState) {
      if (!sessionReceived) {
        sessionReceived = true;
        gameSession = ValueNotifier(newGameSessionState);

        Navigator.of(context).pop();
        Navigator.pushNamed(context, WaitingRoomScreen.routeName,
            arguments: WaitingRoomScreenArguments(
                gameSession: gameSession, sessionEngine: sessionEngine));
        return;
      }
      gameSession.value = newGameSessionState;
      debugPrint('game status updated');
    });

    sessionEngine.onTaskStart((currentTask) {
      debugPrint(currentTask.index.toString());
      TaskInfo taskInfo = gameSession.value.tasks[currentTask.index];

      Navigator.pushNamed(context, TaskScreen.routeName,
          arguments: TaskScreenArguments(
              taskInfo: taskInfo,
              currentTask: currentTask,
              sessionEngine: sessionEngine,
              tasksCount: gameSession.value.tasks.length));
    });

    sessionEngine.onTaskEnd((taskResults) {
      TaskInfo taskInfo = gameSession.value.tasks[taskResults.index];

      Navigator.pushNamed(context, TaskResultsScreen.routeName,
          arguments: TaskResultsScreenArguments(
              sessionEngine: sessionEngine,
              taskResults: taskResults,
              taskInfo: taskInfo,
              gameName: gameSession.value.name,
              players: gameSession.value.players,
              tasksCount: gameSession.value.tasks.length));
    });

    sessionEngine.onGameEnd((gameResults) {
      Navigator.pushNamed(context, GameResultsScreen.routeName,
          arguments: GameResultsScreenArguments(
              gameName: gameSession.value.name,
              gameResults: gameResults,
              players: gameSession.value.players));
    });

    sessionEngine.onPollStart((pollInfo) {
      TaskInfo taskInfo = gameSession.value.tasks[pollInfo.index];

      Navigator.pushNamed(context, VotingScreen.routeName,
          arguments: VotingScreenArguments(
              sessionEngine: sessionEngine,
              pollInfo: pollInfo,
              taskInfo: taskInfo,
              gameName: gameSession.value.name,
              tasksCount: gameSession.value.tasks.length));
    });

    sessionEngine.onGameInterrupted((reason) {
      Navigator.pushNamed(context, MainMenuScreen.routeName);
      showMessage(context, "Игра завершена: $reason");
    });
  }
}
