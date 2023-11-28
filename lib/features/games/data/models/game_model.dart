import 'package:moor_flutter/moor_flutter.dart';
import 'package:party_games_app/core/database/app_database.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:collection/collection.dart';

class GameModel {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUri;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TaskModel>? tasks;
  final Source? source;

  GameModel(
      {this.id,
      this.name,
      this.description,
      this.imageUri,
      this.createdAt,
      this.updatedAt,
      this.tasks,
      this.source});

  // Domain

  Game toEntity() {
    return Game(
        id: id,
        name: name ?? "",
        description: description,
        imageUri: imageUri,
        tasks: tasks?.map((task) => task.toEntity()).toList() ?? [],
        createdAt: createdAt,
        updatedAt: updatedAt,
        source: source ?? Source.owned);
  }

  factory GameModel.fromEntity(Game game) {
    return GameModel(
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
        id: id != null ? Value(id!) : const Value.absent(),
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

  factory GameModel.fromTables(LocalGame game, List<TaskModel> tasks) {
    return GameModel(
        id: game.id,
        name: game.name,
        description: game.description,
        imageUri: game.imageUri,
        createdAt: game.createdAt,
        updatedAt: game.updatedAt,
        tasks: tasks);
  }

  // JSON

  factory GameModel.fromJson(Map<String, dynamic> map) {
    return GameModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageUri'],
        tasks: map['tasks'] ?? [],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'game-type': 'private',
      'name': name ?? '',
      'description': description ?? '',
      'img-request': 0,
      'tasks': tasks?.mapIndexed((i, task) {
        var taskJson = task.toJson();
        taskJson.addAll(<String, dynamic>{'img-request': i + 1});
        return taskJson;
      }).toList()
    };
    return json;
  }
}
