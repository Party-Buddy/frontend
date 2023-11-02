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

  Task get baseTask => this;

  Task copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUri,
    int? duration,
    TaskType? type,
    DateTime? createdAt,
    DateTime? updatedAt
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUri: imageUri ?? this.imageUri,
      duration: duration ?? this.duration,
      type : type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }

}
