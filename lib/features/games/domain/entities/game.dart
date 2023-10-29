import '../../../tasks/domain/entities/task.dart';

const minPlayersCount = 2;
const maxPlayersCount = 12;

class Game {
  String name;
  String? photoUrl;
  List<Task> tasks;

  Game({required this.name, this.photoUrl, required this.tasks});
}
