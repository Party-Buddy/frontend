import 'package:party_games_app/features/user_data/domain/entities/username.dart';

abstract class UsernameRepository {
  Future<Username> getSavedOrDefaultUsername();

  Future<void> saveUsername(Username task);

  Future<String> getUserId();
}
