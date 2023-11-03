import 'package:party_games_app/features/username/domain/entities/username.dart';

abstract class UsernameRepository {

  Future<Username> getSavedOrDefaultUsername();

  Future<void> saveUsername(Username task);

} 