import 'package:floor/floor.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';

@Entity(tableName: 'games')
class LocalGameModel{

  @PrimaryKey(autoGenerate: true)
  final int id;
  final String description;
  final String name;
  final String? imageUri;
  final int createdAt;
  final int updatedAt;

  const LocalGameModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUri,
    required this.createdAt,
    required this.updatedAt
    });

}