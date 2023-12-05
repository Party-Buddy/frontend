import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/user_data/domain/entities/username.dart';
import 'package:party_games_app/features/user_data/domain/repository/user_data_repository.dart';

class GetUsernameUseCase implements UseCase<Username, void> {
  final UsernameRepository _usernameRepository;

  GetUsernameUseCase(this._usernameRepository);

  @override
  Future<Username> call({void params}) {
    return _usernameRepository.getSavedOrDefaultUsername();
  }
}
