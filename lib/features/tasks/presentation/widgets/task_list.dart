import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/async/future.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/resources/source_enum.dart';
import 'package:party_games_app/core/widgets/future_builder_wrapper.dart';
import 'package:party_games_app/core/widgets/option_switcher.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_local_tasks.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_local_tasks_sorted.dart';
import 'package:party_games_app/features/tasks/domain/usecases/get_published_tasks.dart';
import 'package:party_games_app/features/tasks/domain/usecases/params/tasks_sort_params.dart';
import 'package:party_games_app/features/tasks/presentation/widgets/task_header.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key, required this.onTapOnTask});

  final void Function(Task) onTapOnTask;

  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Source source = Source.owned;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OptionSwitcher<Source>(
        options: Source.values,
        onTap: (t) => setState(() => source = t),
        initialOption: source,
        stringMapper: (t) => t == Source.owned ? "Ваши" : "Публичные",
      ),
      const SizedBox(
        height: kPadding,
      ),
      buildTaskList(context, onTapOnTask: widget.onTapOnTask, source: source)
    ]);
  }
}

final GetLocalTasksUseCase _getLocalTasksUseCase =
    GetIt.instance<GetLocalTasksUseCase>();
final GetLocalTasksSortedUseCase _getLocalTasksSortedUseCase =
    GetIt.instance<GetLocalTasksSortedUseCase>();
final GetPublishedTasksUseCase _getPublishedTasksUseCase =
    GetIt.instance<GetPublishedTasksUseCase>();

FutureBuilderWrapper<DataState<List<Task>>> buildTaskList(BuildContext context,
    {required Function(Task) onTapOnTask,
    required Source source,
    TasksSortParams? params}) {
  return FutureBuilderWrapper(
      future: source == Source.public
          ? convertFutureDataState(_getPublishedTasksUseCase.call())
          : params == null
              ? convertFuture(_getLocalTasksUseCase.call())
              : convertFuture(
                  _getLocalTasksSortedUseCase.call(params: params)),
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
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .6,
          ),
          padding: const EdgeInsets.only(bottom: kPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: kPadding),
            child: Column(
              children: data.data!
                  .map((task) => Padding(
                      padding: const EdgeInsets.all(kPadding / 2).add(
                          const EdgeInsets.symmetric(horizontal: kPadding / 2)),
                      child: TaskHeader(
                          task: task, onTap: () => onTapOnTask(task))))
                  .toList(),
            ),
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
