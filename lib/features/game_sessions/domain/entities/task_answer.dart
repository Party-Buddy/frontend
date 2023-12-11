import 'dart:io';

abstract class Answer {
  String get taskType;
  dynamic get answer;
}

class TextTaskAnswer extends Answer {
  final String _answer;

  TextTaskAnswer({required String answer}) : _answer = answer;

  @override
  dynamic get answer => _answer;

  @override
  String get taskType => 'text';
}

class CheckedTextTaskAnswer extends Answer {
  final String _answer;
  CheckedTextTaskAnswer({required String answer}) : _answer = answer;

  @override
  dynamic get answer => _answer;

  @override
  String get taskType => 'checked-text';
}

class ChoiceTaskAnswer extends Answer {
  final int choice;
  ChoiceTaskAnswer({required this.choice});

  @override
  dynamic get answer => choice;

  @override
  String get taskType => 'option';
}

class ImageTaskAnswer extends Answer {
  final File file;
  final String uri;
  ImageTaskAnswer({required this.file, required this.uri});

  @override
  dynamic get answer => file.uri;

  @override
  String get taskType => 'image-uri';
}
