import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:collection/collection.dart';

abstract class GameModel {
  final String? name;
  final String? description;
  final String? imageUri;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TaskModel>? tasks;

  GameModel(
      {this.name,
      this.description,
      this.imageUri,
      this.createdAt,
      this.updatedAt,
      this.tasks});

  // Domain

  Game toEntity();

  factory GameModel.fromEntity(Game game) {
    if (game is OwnedGame) {
      return OwnedGameModel.fromEntity(game);
    } else if (game is PublishedGame) {
      return PublishedGameModel.fromEntity(game);
    } else {
      throw Error();
    }
  }

  Map<String, dynamic> toJson();
}

class OwnedGameModel extends GameModel {
  int? id;
  OwnedGameModel(
      {this.id,
      super.name,
      super.description,
      super.imageUri,
      super.createdAt,
      super.updatedAt,
      super.tasks});

  @override
  Map<String, dynamic> toJson() {
    var gameJson = <String, dynamic>{
      'name': name ?? '',
      'description': description ?? '',
      'img-request': 0,
      'tasks': tasks?.mapIndexed((i, task) {
        var taskJson = task.toJson();
        taskJson.addAll(<String, dynamic>{'img-request': i + 1});
        return taskJson;
      }).toList()
    };
    return <String, dynamic>{'game-type': 'private', 'game': gameJson};
  }

  @override
  Game toEntity() {
    return OwnedGame(
        id: id ?? 0,
        name: name ?? "",
        description: description,
        imageUri: imageUri,
        tasks: tasks?.map((task) => task.toEntity()).toList() ?? [],
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  factory OwnedGameModel.fromEntity(OwnedGame game) {
    return OwnedGameModel(
        id: game.id,
        name: game.name,
        description: game.description,
        imageUri: game.imageUri,
        createdAt: game.createdAt,
        updatedAt: game.updatedAt,
        tasks: game.tasks.map((task) => TaskModel.fromEntity(task)).toList());
  }

  // Storage

  Insertable<LocalGame> toInsertable() {
    return LocalGamesCompanion(
        name: name != null ? Value(name!) : const Value.absent(),
        description:
            description != null ? Value(description!) : const Value.absent(),
        imageUri: imageUri != null ? Value(imageUri!) : const Value.absent(),
        createdAt:
            createdAt != null ? Value(createdAt!) : Value(DateTime.now()),
        updatedAt: Value(DateTime.now()));
  }

  Insertable<TaskBinding> toBinding({int? taskId, int? taskOrder}) {
    return TaskBindingsCompanion(
        gameId: id != null ? Value(id!) : const Value.absent(),
        baseTaskId: taskId != null ? Value(taskId) : const Value.absent(),
        gameOrder: taskOrder != null ? Value(taskOrder) : const Value.absent());
  }

  factory OwnedGameModel.fromTables(LocalGame game, List<TaskModel> tasks) {
    return OwnedGameModel(
        id: game.id,
        name: game.name,
        description: game.description,
        imageUri: game.imageUri,
        createdAt: game.createdAt,
        updatedAt: game.updatedAt,
        tasks: tasks);
  }
}

class PublishedGameModel extends GameModel {
  String? id;
  PublishedGameModel(
      {this.id,
      super.name,
      super.description,
      super.imageUri,
      super.createdAt,
      super.updatedAt,
      super.tasks});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'game-type': 'public', 'game-id': id ?? ''};
  }

  factory PublishedGameModel.fromJson(Map<String, dynamic> map) {
    return PublishedGameModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['img-uri'],
        tasks: map['tasks'] ?? [],
        updatedAt: map['date-changed']);
  }

  @override
  Game toEntity() {
    return PublishedGame(
        id: id ?? "",
        name: name ?? "",
        description: description,
        imageUri: imageUri,
        tasks: tasks?.map((task) => task.toEntity()).toList() ?? [],
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  factory PublishedGameModel.fromEntity(PublishedGame game) {
    return PublishedGameModel(
        id: game.id,
        name: game.name,
        description: game.description,
        imageUri: game.imageUri,
        createdAt: game.createdAt,
        updatedAt: game.updatedAt,
        tasks: game.tasks.map((task) => TaskModel.fromEntity(task)).toList());
  }
}
