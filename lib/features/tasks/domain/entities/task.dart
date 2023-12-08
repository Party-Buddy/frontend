enum TaskType { poll, checkedText, choice }

abstract class Task {
  final String name;
  final String description;
  final String? imageUri;
  final int duration;
  final TaskType type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String get hashId;

  const Task(
      {required this.name,
      required this.description,
      this.imageUri,
      required this.duration,
      required this.type,
      this.createdAt,
      this.updatedAt});

  Task get baseTask => this;

  Task copyWith();
}

class OwnedTask extends Task {
  final int? id;

  OwnedTask(
      {this.id,
      required super.name,
      required super.description,
      super.imageUri,
      required super.duration,
      required super.type,
      super.createdAt,
      super.updatedAt});

  @override
  OwnedTask copyWith(
      {int? id,
      String? name,
      String? description,
      String? imageUri,
      int? duration,
      TaskType? type,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return OwnedTask(
        id: id ?? this.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        duration: duration ?? super.duration,
        type: type ?? super.type,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt);
  }
  
  @override
  String get hashId => 'o$id';
}

class PublishedTask extends Task {
  final String? id;

  PublishedTask(
      {this.id,
      required super.name,
      required super.description,
      super.imageUri,
      required super.duration,
      required super.type,
      super.createdAt,
      super.updatedAt});

  @override
  PublishedTask copyWith(
      {String? id,
      String? name,
      String? description,
      String? imageUri,
      int? duration,
      TaskType? type,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return PublishedTask(
        id: id ?? this.id,
        name: name ?? super.name,
        description: description ?? super.description,
        imageUri: imageUri ?? super.imageUri,
        duration: duration ?? super.duration,
        type: type ?? super.type,
        createdAt: createdAt ?? super.createdAt,
        updatedAt: updatedAt ?? super.updatedAt);
  }
  
  @override
  String get hashId => 'p$id';
}
