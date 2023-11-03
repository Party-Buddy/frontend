import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/username/domain/repository/username_repository.dart';
import 'package:party_games_app/features/username/domain/usecases/params/username_params.dart';

class SaveUsernameUseCase implements UseCase<void, UsernameParams>{

  final UsernameRepository _usernameRepository;

  SaveUsernameUseCase(this._usernameRepository);

  @override
  Future<void> call({required UsernameParams params}) {
    return _usernameRepository.saveUsername(params.username);
  }

}