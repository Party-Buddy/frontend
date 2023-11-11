import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/async/future.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/widgets/future_builder_wrapper.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_local_tasks.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_published_tasks.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_header.dart';

final GetLocalTasksUseCase _getLocalTasksUseCase =
    GetIt.instance<GetLocalTasksUseCase>();
final GetPublishedTasksUseCase _getPublishedTasksUseCase =
    GetIt.instance<GetPublishedTasksUseCase>();

FutureBuilderWrapper<DataState<List<Task>>> buildTaskList(
    {required Function(Task) onTapOnTask, required Source source}) {
  return FutureBuilderWrapper(
      future: source == Source.public
          ? convertFutureDataState(_getPublishedTasksUseCase.call())
          : convertFuture(_getLocalTasksUseCase.call()),
      notFoundWidget: () =>
          buildNotFoundWidget(text: "У вас пока нет своих заданий."),
      builder: (data) {
        if (data.error != null) {
          return Container(); // TO DO: handle errors
        }
        debugPrint(data.data!.toString());
        if (data.data!.isEmpty) {
          String text;
          if (source == Source.owned) {
            text = "У вас пока нет своих заданий.";
          } else {
            text = "Задания из каталога на данный момент недоступны.";
          }
          return buildNotFoundWidget(text: text);
        }
        return SingleChildScrollView(
          child: Column(
            children: data.data!
                .map((task) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: kPadding / 2),
                    child:
                        TaskHeader(task: task, onTap: () => onTapOnTask(task))))
                .toList(),
          ),
        );
      });
}

Widget buildNotFoundWidget({required String text}) {
  return Container(
    alignment: Alignment.center,
    padding: kPaddingAll,
    child: Text(
      text,
      style: defaultTextStyle(),
    ),
  );
}
