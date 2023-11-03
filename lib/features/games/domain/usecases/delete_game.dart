import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/usecases/params/game_params.dart';

class DeleteGameUseCase implements UseCase<void, GameParams>{

  final GameRepository _gameRepository;

  DeleteGameUseCase(this._gameRepository);

  @override
  Future<void> call({required GameParams params}) {
    return _gameRepository.deleteGame(params.game);
  }

}