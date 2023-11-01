import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';

class GamesGenerator {
  List<Game> generateGames1(){
    return [
      Game(
        id: 2,
        name: "Minecraft",
        imageId: "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
        tasks: [const CheckedTextTask(
          id: 0,
          name:"Basics0",
          description: "what is the max stack size for wood?",
          duration: 10,
          answer: "64"),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
      Game(
        id: 0,
        name: "Terraria",
        imageId: "https://i.postimg.cc/x12wFcdv/pngegg.png",
        tasks: [const CheckedTextTask(
          id: 1,
          name:"The Weapon",
          description: "what is the best melee weapon?",
          duration: 15,
          answer: "zenith"),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch)
      ];
  }

  List<Game> generateGames2(){
    return [
      Game(
        id: 18,
        name: "Minecraft",
        imageId: "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
        tasks: [const CheckedTextTask(
          id: 999,
          name:"Basics1",
          description: "what is the max stack size for swords?",
          duration: 10,
          answer: "1"),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
      Game(
        id:18020,
        name: "CS:GO",
        imageId: "https://seeklogo.com/images/C/counter-strike-global-offensive-logo-CFCEFBBCE2-seeklogo.com.png",
        tasks: [const PollTask(
          id: 998,
          name:"Skins",
          description: "Draw a fork skin",
          duration: 150,
          pollAnswerType: PollTaskAnswerType.image),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch)
      ];
  }

}