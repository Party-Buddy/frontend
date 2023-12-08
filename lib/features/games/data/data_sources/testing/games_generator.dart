import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/remote_games_source.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';

class GamesGenerator implements RemoteGamesDataSource {
  @override
  Future<DataState<List<Game>>> getGames() async {
    return DataSuccess([
      PublishedGame(
          id: '11112222-3333-4444-5555-131072262144',
          name: "Minecraft",
          imageUri:
              "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
          tasks: [
            PublishedCheckedTextTask(
                id: 'todo',
                name: "Basics0",
                description: "what is the max stack size for wood?",
                duration: 10,
                answer: "64"),
            PublishedCheckedTextTask(
                id: 'todo',
                name: "Basics1",
                description: "what is the max stack size for swords?",
                duration: 10,
                answer: "1")
          ],
          updatedAt: DateTime.now()),
      PublishedGame(
          id: '66667777-8888-9999-0000-167772161024',
          name: "Terraria",
          imageUri: "https://toppng.com/public/uploads/preview/tree-terraria-tree-logo-115630004484aweqy3qjv.png",
          tasks: [
            PublishedCheckedTextTask(
                id: 'todo',
                name: "The Weapon",
                description: "what is the best melee weapon?",
                duration: 15,
                answer: "zenith"),
          ],
          updatedAt: DateTime.now())
    ]);
  }

  List<Game> generateGames2() {
    return [
      PublishedGame(
          id: '11112222-3333-4444-5555-131072262144',
          name: "Minecraft",
          imageUri:
              "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
          tasks: [
            PublishedCheckedTextTask(
                id: 'todo',
                name: "Basics1",
                description: "what is the max stack size for swords?",
                duration: 10,
                answer: "1"),
          ],
          updatedAt: DateTime.now()),
      PublishedGame(
          id: '66667777-8888-9999-0000-167772161024',
          name: "CS:GO",
          imageUri:
              "https://seeklogo.com/images/C/counter-strike-global-offensive-logo-CFCEFBBCE2-seeklogo.com.png",
          tasks: [
            PublishedPollTask(
                id: 'todo',
                name: "Skins",
                description: "Draw a fork skin",
                duration: 150,
                pollAnswerType: PollTaskAnswerType.image,
                pollDynamicDuration: 0,
                pollFixedDuration: 10),
          ],
          updatedAt: DateTime.now())
    ];
  }
}
