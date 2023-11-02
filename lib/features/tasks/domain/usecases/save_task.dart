import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';

class SaveTaskUseCase implements UseCase<Task, Task>{

  final TaskRepository _taskRepository;

  SaveTaskUseCase(this._taskRepository);

  @override
  Future<Task> call({required Task params}) {
    return _taskRepository.saveTask(params);
  }

}