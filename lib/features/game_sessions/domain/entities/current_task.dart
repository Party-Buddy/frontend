class CurrentTask {
  final int index;
  final int deadline;
  final List<String>? options;
  final String? imageUri;

  const CurrentTask({
    required this.index,
    required this.deadline,
    this.imageUri,
    this.options,
  });
}
