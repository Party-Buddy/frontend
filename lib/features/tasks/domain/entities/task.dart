enum TaskType {
  poll,
  checkedText,
  choice
}

class Task {
  final int? id;
  final String name;
  final String description;
  final String? imageUri;
  final int duration;
  final TaskType type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  
  const Task({
    this.id,
    required this.name,
    required this.description,
    this.imageUri,
    required this.duration,
    required this.type,
    this.createdAt,
    this.updatedAt
    });
}
