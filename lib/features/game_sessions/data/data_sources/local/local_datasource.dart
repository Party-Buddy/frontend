import 'package:shared_preferences/shared_preferences.dart';

const String _sidKey = 'last_session_uid';

class LocalSessionDatasource {
  final SharedPreferences preferences;

  LocalSessionDatasource(this.preferences);

  Future<void> saveSID(String sid) async {
    preferences.setString(_sidKey, sid);
  }

  Future<String?> getSID() async {
    String? sid = preferences.getString(_sidKey);
    if (sid == ''){
      sid = null;
    }
    return sid;
  }
}
