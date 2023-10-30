enum TaskTypes {
  poll,
  checkedText,
  choice
}

class Task {
  final String name;
  final String description;
  final String? imageId;
  final int duration;
  final TaskTypes type;
  
  
  const Task({required this.name, required this.description, this.imageId, required this.duration, required this.type});
}
