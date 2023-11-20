import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/usecases/params/games_sort_params.dart';

class GetLocalGamesSortedUseCase
    implements UseCase<List<Game>, GamesSortParams> {
  final GameRepository _gameRepository;

  GetLocalGamesSortedUseCase(this._gameRepository);

  @override
  Future<List<Game>> call({required GamesSortParams params}) {
    if (params.tasksCountAscending != null) {
      return _gameRepository.getLocalGames().then((tasks) {
        tasks.sort((a, b) => params.tasksCountAscending!
            ? a.tasks.length.compareTo(b.tasks.length)
            : b.tasks.length.compareTo(a.tasks.length));
        return tasks;
      });
    } else if (params.nameAscending != null) {
      return _gameRepository.getLocalGamesSortedByName(params.nameAscending!);
    } else {
      return _gameRepository
          .getLocalGamesSortedByUpdateDate(params.updateDateAscending ?? false);
    }
  }
}
