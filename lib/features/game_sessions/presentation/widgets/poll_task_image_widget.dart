import 'package:flutter/material.dart';
import 'package:party_games_app/core/widgets/image_uploader.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';

class PollTaskImageWidget extends StatefulWidget {
  const PollTaskImageWidget({super.key, required this.pollTask});

  final PollTask pollTask;

  @override
  State<PollTaskImageWidget> createState() => _PollTaskImageWidget();
}

class _PollTaskImageWidget extends State<PollTaskImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ImageUploader(isOptional: false, onUpdate: (image) {})],
    );
  }
}
