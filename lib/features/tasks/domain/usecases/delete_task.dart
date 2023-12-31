import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';
import 'package:party_games_app/features/tasks/domain/usecases/params/task_params.dart';

class DeleteTaskUseCase implements UseCase<bool, TaskParams>{

  final TaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  @override
  Future<bool> call({required TaskParams params}) {
    return _taskRepository.deleteTask(params.task);
  }

}