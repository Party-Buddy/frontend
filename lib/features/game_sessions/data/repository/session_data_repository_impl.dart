import 'package:party_games_app/core/resources/data_state.dart';
import 'package:party_games_app/features/game_sessions/data/data_sources/local/local_datasource.dart';
import 'package:party_games_app/features/game_sessions/domain/repository/session_data_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final LocalSessionDatasource localDatasource;

  SessionRepositoryImpl(this.localDatasource);

  @override
  Future<void> clearSession() async {
    localDatasource.saveSID('');
  }

  @override
  Future<DataState<String>> getSession() async {
    var uid = await localDatasource.getSID();
    return uid == null
        ? const DataFailed('no session found')
        : DataSuccess(uid);
  }

  @override
  Future<void> saveSession(String sid) async {
    localDatasource.saveSID(sid);
  }
}
