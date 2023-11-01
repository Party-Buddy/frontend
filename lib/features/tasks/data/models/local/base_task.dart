import 'package:floor/floor.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';

@Entity(tableName: 'task')
class BaseTaskModel{
  
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String description;
  final String? imageUri;
  final int duration;
  final TaskTypes type;

  const BaseTaskModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUri,
    required this.duration,
    required this.type});


}