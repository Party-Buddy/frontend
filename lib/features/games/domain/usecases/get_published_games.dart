import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/game_repository.dart';

class GetPublishedGamesUseCase implements UseCase<DataState<List<Game>>, void>{

  final GameRepository _gameRepository;

  GetPublishedGamesUseCase(this._gameRepository);

  @override
  Future<DataState<List<Game>>> call({void params}) {
    return _gameRepository.getPublishedGames();
  }

}