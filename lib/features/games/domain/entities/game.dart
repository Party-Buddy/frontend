import '../../../tasks/domain/entities/task.dart';

const minPlayersCount = 2;
const maxPlayersCount = 12;

class Game {
  final int? id;
  final String name;
  final String? description;
  final String? imageUri;
  final List<Task> tasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Game({
    this.id,
    required this.name,
    this.description,
    this.imageUri,
    required this.tasks,
    this.createdAt,
    this.updatedAt
    });
}
