import 'package:party_games_app/features/tasks/domain/entities/task.dart';

class PublishedGameModel{

  final int id;
  final String description;
  final String name;
  final String? imageUri;
  final List<Task> tasks;
  final int createdAt;
  final int updatedAt;

  const PublishedGameModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUri,
    required this.tasks,
    required this.createdAt,
    required this.updatedAt
    });

    factory PublishedGameModel.fromJson(Map<String, dynamic> map) {
      return PublishedGameModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imageUri: map['imageUri'] ?? "",
        tasks: map['tasks'] ?? [],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt']
      );
    }

}