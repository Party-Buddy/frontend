import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/task_repository.dart';

class GetLocalTasksUseCase implements UseCase<DataState<List<Task>>, void>{

  final TaskRepository _taskRepository;

  GetLocalTasksUseCase(this._taskRepository);

  @override
  Future<DataState<List<Task>>> call({void params}) {
    return _taskRepository.getLocalTasks();
  }

}