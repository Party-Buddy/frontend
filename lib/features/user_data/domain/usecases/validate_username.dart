import 'package:party_games_app/core/usecase/usecase.dart';
import 'package:party_games_app/features/user_data/domain/usecases/params/username_params.dart';

class ValidateUsernameUseCase implements UseCase<bool, UsernameParams> {
  final _nicknameRegex = RegExp(r'^[a-zA-Zа-яА-ЯёЁ0-9_.\s]{1,20}$');

  static const nicknameRequirements =
      "Никнейм должен содержать от 1 до 20 символов и включать в себя только латинские символы, символы русского алфавита, пробел, символы '.', '_' и цифры.";

  ValidateUsernameUseCase();

  @override
  Future<bool> call({required UsernameParams params}) async {
    return _nicknameRegex.hasMatch(params.username.username);
  }
}
