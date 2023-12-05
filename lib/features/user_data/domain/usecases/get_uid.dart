import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/user_data/domain/repository/user_data_repository.dart';

class GetUIDUseCase implements UseCase<String, void> {
  final UsernameRepository _usernameRepository;

  GetUIDUseCase(this._usernameRepository);

  @override
  Future<String> call({void params}) {
    return _usernameRepository.getUserId();
  }
}
