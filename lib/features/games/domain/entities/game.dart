import '../../../tasks/domain/entities/task.dart';

const minPlayersCount = 2;
const maxPlayersCount = 12;

class Game {
  final int id;
  final String name;
  final String? imageId;
  final List<Task> tasks;
  final int lastModifiedTime;

  const Game({
    required this.id,
    required this.name,
    this.imageId,
    required this.tasks,
    required this.lastModifiedTime
    });
}
