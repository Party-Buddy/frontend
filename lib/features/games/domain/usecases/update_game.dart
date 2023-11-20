import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';
import 'package:party_games_app/features/games/domain/usecases/params/game_params.dart';

class UpdateGameUseCase implements UseCase<Game, GameParams>{

  final GameRepository _gameRepository;

  UpdateGameUseCase(this._gameRepository);

  @override
  Future<Game> call({required GameParams params}) {
    return _gameRepository.updateGame(params.game);
  }

}