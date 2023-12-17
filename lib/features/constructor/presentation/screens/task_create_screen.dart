import 'dart:io';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:party_games_app/config/theme/commons.dart';
import 'package:party_games_app/config/utils.dart';
import 'package:party_games_app/config/view_config.dart';
import 'package:party_games_app/core/widgets/base_screen.dart';
import 'package:party_games_app/core/widgets/border_wrapper.dart';
import 'package:party_games_app/core/widgets/custom_button.dart';
import 'package:party_games_app/core/widgets/custom_icon_button.dart';
import 'package:party_games_app/core/widgets/dropdown_button.dart';
import 'package:party_games_app/core/widgets/image_uploader.dart';
import 'package:party_games_app/core/widgets/labeled_slider.dart';
import 'package:party_games_app/core/widgets/multiline_input_label.dart';
import 'package:party_games_app/core/widgets/single_input_label.dart';
import 'package:party_games_app/features/constructor/presentation/screens/constructor_screen.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/usecases/params/task_params.dart';
import 'package:party_games_app/features/tasks/domain/usecases/save_task.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({super.key});

  static const String routeName = "/TaskCreate";

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  File? image;
  String name = "";
  String description = "";
  int duration = 30;

  String answer = "";
  final optionsNotifier = ValueNotifier([]);
  PollTaskAnswerType pollAnswerType = PollTaskAnswerType.text;

  final SaveTaskUseCase _saveTaskUseCase = GetIt.instance<SaveTaskUseCase>();
  final taskTypeNotifier = ValueNotifier(TaskType.checkedText);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBarTitle: "Создать задание",
        resizeToAvoidBottomInset: true,
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: kPadding,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: kPadding),
                child: ImageUploader(onUpdate: (image) => this.image = image),
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              SingleLineInputLabel(
                  labelText: "Название задания",
                  onSubmitted: (submittedName) async {
                    setState(() {
                      name = submittedName;
                    });
                    return SubmitResult.empty;
                  }),
              const SizedBox(
                height: kPadding * 2,
              ),
              MultiLineInputLabel(
                  labelText: "Описание задания",
                  onSubmitted: (submittedDesc) {
                    setState(() {
                      description = submittedDesc;
                    });
                  }),
              const SizedBox(
                height: kPadding * 2,
              ),
              LabeledSlider(
                min: 1,
                max: 18,
                fillColor: kAppBarColor,
                initial: duration ~/ 5,
                onChanged: (int newVal) {
                  duration = newVal * 5;
                },
                displayValue: (int seconds) {
                  seconds *= 5;
                  return "Длительность задания: $seconds секунд";
                },
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderWrapper(
                        borderColor: kPrimaryColor,
                        child: Text(
                          "Тип задания",
                          style: defaultTextStyle(),
                        )),
                    CustomDropDownButton(
                        width: 160,
                        initialItem: taskTypeNotifier.value,
                        items: TaskType.values,
                        stringMapper: (taskType) {
                          switch (taskType) {
                            case TaskType.checkedText:
                              return "С проверкой текста";
                            case TaskType.choice:
                              return "С выбором ответа";
                            case TaskType.poll:
                              return "С голосованием";
                          }
                        },
                        onChanged: (taskType) {
                          setState(() {
                            taskTypeNotifier.value = taskType;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: kPadding * 2,
              ),
              ValueListenableBuilder(
                  valueListenable: taskTypeNotifier,
                  builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPadding / 2),
                        child: buildTaskTypeContent(context, taskType: value),
                      )),
              const SizedBox(
                height: kPadding * 2,
              ),
              Visibility(
                  visible: isTaskInfoReady(),
                  child: CustomButton(
                      text: "Создать задание", onPressed: onTaskCreate)),
              const SizedBox(
                height: kPadding * 6,
              ),
            ],
          ),
        ));
  }

  void onTaskCreate() async {
    Task task;
    switch (taskTypeNotifier.value) {
      case TaskType.checkedText:
        task = OwnedCheckedTextTask(
            name: name,
            description: description,
            imageUri: image?.path,
            duration: duration,
            answer: answer);
      case TaskType.poll:
        task = OwnedPollTask(
            name: name,
            description: description,
            imageUri: image?.path,
            duration: duration,
            pollAnswerType: pollAnswerType,
            pollFixedDuration: 20,
            pollDynamicDuration: 5);
      case TaskType.choice:
        task = OwnedChoiceTask(
            name: name,
            description: description,
            imageUri: image?.path,
            duration: duration,
            options: optionsNotifier.value
                .map((option) => ChoiceTaskOption(
                    alternative: option, correct: option == answer))
                .toList());
    }
    await _saveTaskUseCase.call(params: TaskParams(task: task));
    await Future.microtask(() => Navigator.of(context).pop());
    ConstructorScreen.updateNotifier.value =
        ConstructorScreen.updateNotifier.value + 1;
    await Future.microtask(() => showMessage(context, "Задание создано."));
  }

  bool isTaskInfoReady() {
    if (name.isEmpty || description.isEmpty) {
      return false;
    }
    if (taskTypeNotifier.value == TaskType.checkedText && answer.isNotEmpty) {
      return true;
    }
    if (taskTypeNotifier.value == TaskType.poll) {
      return true;
    }
    if (optionsNotifier.value.length == 4 && answer.isNotEmpty) {
      return true;
    }
    return false;
  }

  Widget buildTaskTypeContent(BuildContext context,
      {required TaskType taskType}) {
    switch (taskType) {
      case TaskType.checkedText:
        return buildCheckedTextTaskContent(context);
      case TaskType.choice:
        return buildChoiceTaskContent(context);
      case TaskType.poll:
        return buildPollTaskContent(context);
    }
  }

  Widget buildChoiceTaskContent(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: optionsNotifier,
      builder: (context, options, child) => Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Добавьте 4 варианта ответа",
              style: defaultTextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: kPadding * 2,
          ),
          Wrap(
            spacing: kPadding,
            runSpacing: kPadding,
            children: options
                .map((option) => BorderWrapper(
                      fillColor: lighten(kAppBarColor, .05),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BorderWrapper(
                              child: Text(
                            option,
                            style: defaultTextStyle(),
                          )),
                          const SizedBox(
                            width: kPadding,
                          ),
                          CustomIconButton(
                              onPressed: () => setState(() {
                                    options.remove(option);
                                    optionsNotifier.value = options;
                                    setState(() {});
                                  }),
                              iconData: Icons.close),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(
            height: kPadding * 2,
          ),
          Visibility(
            visible: options.length < 4,
            child: SingleLineInputLabel(
                labelText: "Добавить вариант",
                clearAfterSubmit: true,
                onSubmitted: (submittedOption) async {
                  if (submittedOption.isEmpty) {
                    return SubmitResult.empty;
                  }
                  if (options.contains(submittedOption)) {
                    return SubmitResult.empty;
                  }
                  answer = submittedOption;
                  options.add(submittedOption);
                  optionsNotifier.value = options;
                  setState(() {});
                  return SubmitResult.empty;
                }),
          ),
          const SizedBox(
            height: kPadding * 2,
          ),
          Visibility(
            visible: options.length == 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BorderWrapper(
                    borderColor: kPrimaryColor,
                    child: Text(
                      "Правильный ответ",
                      style: defaultTextStyle(),
                    )),
                CustomDropDownButton(
                    width: 150,
                    initialItem: answer,
                    items: options,
                    stringMapper: (s) => s,
                    onChanged: (choice) {
                      answer = choice;
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPollTaskContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BorderWrapper(
            borderColor: kPrimaryColor,
            child: Text(
              "Тип ответа",
              style: defaultTextStyle(),
            )),
        CustomDropDownButton(
            width: 150,
            initialItem: pollAnswerType,
            items: PollTaskAnswerType.values,
            stringMapper: (pollType) {
              switch (pollType) {
                case PollTaskAnswerType.text:
                  return "Текст";
                case PollTaskAnswerType.image:
                  return "Изображение";
              }
            },
            onChanged: (choice) {
              pollAnswerType = choice;
            }),
      ],
    );
  }

  Widget buildCheckedTextTaskContent(BuildContext context) {
    return SingleLineInputLabel(
        labelText: "Правильный ответ",
        onSubmitted: (submittedAnswer) async {
          answer = submittedAnswer;
          setState(() {});
          if (answer.isNotEmpty) {
            return SubmitResult.success;
          }
          return SubmitResult.empty;
        });
  }
}
