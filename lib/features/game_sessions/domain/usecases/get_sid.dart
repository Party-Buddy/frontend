import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/game_sessions/domain/repository/session_data_repository.dart';

class GetSIDUseCase implements UseCase<DataState<String>, void> {
  final SessionRepository _sessionRepository;

  GetSIDUseCase(this._sessionRepository);

  @override
  Future<DataState<String>> call({void params}) {
    return _sessionRepository.getSession();
  }
}
