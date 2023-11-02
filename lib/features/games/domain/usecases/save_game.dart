import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';

class SaveGameUseCase implements UseCase<Game, Game>{

  final GameRepository _gameRepository;

  SaveGameUseCase(this._gameRepository);

  @override
  Future<Game> call({required Game params}) {
    return _gameRepository.saveGame(params);
  }

}