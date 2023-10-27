import '../../../tasks/domain/entities/task.dart';

class Game {
  String name;
  String? photoUrl;
  List<Task> tasks;

  Game({required this.name, this.photoUrl, required this.tasks});
}
