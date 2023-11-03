import 'dart:convert';
import 'package:party_games_app/features/username/data/model/username_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _usernameKey = 'username_username';
const String _colorKey = 'username_color';

class LocalUsernameDatasource {

  final SharedPreferences preferences;

  LocalUsernameDatasource(this.preferences);

  Future<UsernameModel> getSavedUsername() async{
    var colorString = preferences.getString(_colorKey);
    ({int a, int r, int g, int b})? color = colorString != null ? jsonDecode(colorString) : null;

    return UsernameModel(
      username: preferences.getString(_usernameKey),
      color: color
      );
  }

  Future<void> saveUsername(UsernameModel username) async{
    if (username.username != null) {
      preferences.setString(_usernameKey, username.username!);
    }
    preferences.setString(_colorKey, jsonEncode(username.color));
  }

}