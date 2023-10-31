import 'package:party_games_app/features/games/data/models/game.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';

class GamesGenerator {
  List<GameModel> generateGames1(){
    return [
      GameModel(name: "Minecraft",
        imageId: "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
        tasks: [const CheckedTextTask(
          name:"Basics0",
          description: "what is the max stack size for wood?",
          duration: 10,
          answer: "64"),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
        GameModel(name: "Terraria",
        imageId: "https://i.postimg.cc/x12wFcdv/pngegg.png",
        tasks: [const CheckedTextTask(
          name:"The Weapon",
          description: "what is the best melee weapon?",
          duration: 15,
          answer: "zenith"),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch)
      ];
  }

  List<GameModel> generateGames2(){
    return [
      GameModel(name: "Minecraft",
        imageId: "https://cdn.iconscout.com/icon/free/png-256/free-minecraft-15-282774.png",
        tasks: [const CheckedTextTask(
          name:"Basics1",
          description: "what is the max stack size for swords?",
          duration: 10,
          answer: "1"),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch),
        GameModel(name: "CS:GO",
        imageId: "https://seeklogo.com/images/C/counter-strike-global-offensive-logo-CFCEFBBCE2-seeklogo.com.png",
        tasks: [const PollTask(
          name:"Skins",
          description: "Draw a fork skin",
          duration: 150,
          pollAnswerType: PollTaskAnswerType.image),],
        lastModifiedTime: DateTime.now().millisecondsSinceEpoch)
      ];
  }

}