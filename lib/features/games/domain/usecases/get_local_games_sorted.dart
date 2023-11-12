import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/usecases/params/games_sort_params.dart';

class GetLocalGamesSortedUseCase implements UseCase<List<Game>, GamesSortParams>{

  final GameRepository _gameRepository;

  GetLocalGamesSortedUseCase(this._gameRepository);

  @override
  Future<List<Game>> call({required GamesSortParams params}) {
    if (params.nameAscending != null){
      return _gameRepository.getAllGamesSortedByName(params.nameAscending!);
    }
    else {
      return _gameRepository.getAllGamesSortedByUpdateDate(params.updateDateAscending ?? false);
    }
  }

}