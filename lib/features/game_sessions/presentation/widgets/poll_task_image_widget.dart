import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_games_app/core/widgets/image_uploader.dart';
import 'package:party_games_app/features/game_sessions/domain/engine/session_engine.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/current_task.dart';
import 'package:party_games_app/features/game_sessions/domain/entities/task_answer.dart';
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
  File? uploadedImageFile;
  final readyNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    readyNotifier.addListener(onReadyChanged);
  }

  void onReadyChanged() {
    widget.sessionEngine
        .sendAnswer(widget.currentTask.index, null, ready: readyNotifier.value);
  }

  @override
  void dispose() {
    readyNotifier.removeListener(onReadyChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageUploader(
            isOptional: false,
            onUpdate: (file) {
              widget.sessionEngine.sendAnswer(
                  widget.currentTask.index,
                  ImageTaskAnswer(
                      file: file, uri: widget.currentTask.imageUri!),
                  ready: readyNotifier.value);
              setState(() {
                uploadedImageFile = file;
              });
            }),
        Visibility(
            visible: uploadedImageFile != null,
            child: Container(
                alignment: Alignment.center,
                child: ReadyConfirmationLabel(enabledNotifier: readyNotifier)))
      ],
    );
  }
}
