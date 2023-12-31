import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';
import 'package:party_games_app/features/tasks/domain/usecases/params/task_params.dart';

class SaveTaskUseCase implements UseCase<Task, TaskParams>{

  final TaskRepository _taskRepository;

  SaveTaskUseCase(this._taskRepository);

  @override
  Future<Task> call({required TaskParams params}) {
    return _taskRepository.saveTask(params.task);
  }

}