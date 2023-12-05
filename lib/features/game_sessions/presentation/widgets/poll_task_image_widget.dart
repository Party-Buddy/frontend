import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_games_app/core/widgets/image_uploader.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_info.dart';
import 'package:party_games_app/features/game_sessions/presentation/widgets/ready_confirmation_label.dart';

class PollTaskImageWidget extends StatefulWidget {
  const PollTaskImageWidget(
      {super.key,
      required this.taskInfo,
      required this.currentTask,
      required this.sessionEngine});

  final TaskInfo taskInfo;
  final CurrentTask currentTask;
  final SessionEngine sessionEngine;
  
  @override
  State<PollTaskImageWidget> createState() => _PollTaskImageWidget();
}

class _PollTaskImageWidget extends State<PollTaskImageWidget> {
  File? uploadedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageUploader(
            isOptional: false,
            onUpdate: (image) {
              setState(() {
                uploadedImage = image;
              });
            }),
        Visibility(
            visible: uploadedImage != null,
            child:
                Container(
                  alignment: Alignment.center,
                  child: ReadyConfirmationLabel(enabledNotifier: ValueNotifier(false))))
      ],
    );
  }
}
