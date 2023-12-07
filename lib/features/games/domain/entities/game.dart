import '../../../tasks/domain/entities/task.dart';

abstract class Game {
  final String name;
  final String? description;
  final String? imageUri;
  final List<Task> tasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Game(
      {required this.name,
      this.description,
      this.imageUri,
      required this.tasks,
      this.createdAt,
      this.updatedAt});

  Game copyWith();
}

class OwnedGame extends Game {
  final int? id;

  OwnedGame({
    this.id,
    required super.name,
    super.description,
    super.imageUri,
    super.createdAt,
    super.updatedAt,
    required super.tasks,
  });

  @override
  OwnedGame copyWith(
      {int? id,
      String? name,
      String? description,
      String? imageUri,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<Task>? tasks}) {
    return OwnedGame(
        id: id ?? this.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt,
        tasks: tasks ?? super.tasks);
  }
}

class PublishedGame extends Game {
  final String? id;

  PublishedGame({
    this.id,
    required super.name,
    super.description,
    super.imageUri,
    super.createdAt,
    super.updatedAt,
    required super.tasks,
  });

  @override
  PublishedGame copyWith(
      {String? id,
      String? name,
      String? description,
      String? imageUri,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<Task>? tasks}) {
    return PublishedGame(
        id: id ?? this.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt,
        tasks: tasks ?? super.tasks);
  }
}
