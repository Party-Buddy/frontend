import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';

class GetLocalGamesUseCase implements UseCase<List<Game>, void>{

  final GameRepository _gameRepository;

  GetLocalGamesUseCase(this._gameRepository);

  @override
  Future<List<Game>> call({void params}) {
    return _gameRepository.getLocalGames();
  }

}