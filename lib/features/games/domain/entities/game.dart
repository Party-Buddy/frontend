import '../../../tasks/domain/entities/task.dart';

enum Source { owned, public }

class Game {
  final int? id;
  final String name;
  final String? description;
  final String? imageUri;
  final List<Task> tasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Source source;

  const Game(
      {this.id,
      required this.name,
      this.description,
      this.imageUri,
      required this.tasks,
      this.createdAt,
      this.updatedAt,
      required this.source});

  Game copyWith(
      {int? id,
      String? name,
      String? description,
      String? imageUri,
      List<Task>? tasks,
      DateTime? createdAt,
      DateTime? updatedAt,
      Source? source}) {
    return Game(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUri: imageUri ?? this.imageUri,
        tasks: tasks ?? this.tasks,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        source: source ?? this.source);
  }
}
