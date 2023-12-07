import 'package:party_games_app/core/resources/data_state.dart';

abstract class SessionRepository {

  Future<void> saveSession(String sid);

  Future<void> clearSession();

  Future<DataState<String>> getSession();

}
