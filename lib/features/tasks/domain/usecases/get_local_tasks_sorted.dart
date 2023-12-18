import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/tasks/domain/entities/checked_text_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/choice_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/poll_task.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';
import 'package:party_games_app/features/tasks/domain/usecases/params/tasks_sort_params.dart';

class GetLocalTasksSortedUseCase
    implements UseCase<List<Task>, TasksSortParams> {
  final TaskRepository _taskRepository;

  GetLocalTasksSortedUseCase(this._taskRepository);

  int _typeValue(OwnedTask a) {
    if (a is OwnedPollTask) {
      if (a.pollAnswerType.name == 'image') {
        return 3;
      } else {
        return -1;
      }
    } else if (a is OwnedChoiceTask) {
      return 2;
    } else if (a is OwnedCheckedTextTask) {
      return 1;
    } else {
      throw Error();
    }
  }

  @override
  Future<List<Task>> call({required TasksSortParams params}) async {
    return _taskRepository.getLocalTasks().then((tasks) {
      if (params.typeAscending != null) {
        tasks.sort((a, b) => params.typeAscending!
            ? _typeValue(a).compareTo(_typeValue(b))
            : _typeValue(b).compareTo(_typeValue(a)));
      } else if (params.nameAscending != null) {
        tasks.sort((a, b) => params.nameAscending!
            ? a.name.compareTo(b.name)
            : b.name.compareTo(a.name));
      } else {
        tasks.sort((a, b) => (params.updateDateAscending ?? true)
            ? a.updatedAt!.compareTo(b.updatedAt!)
            : b.updatedAt!.compareTo(a.updatedAt!));
      }
      return tasks;
    });
  }
}
