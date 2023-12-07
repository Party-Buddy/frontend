import 'dart:convert';

import 'package:party_games_app/config/server/paths.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:http/http.dart' as http;
import 'package:party_games_app/features/games/data/models/game_model.dart';
import 'package:party_games_app/features/games/domain/entities/game.dart';
import 'package:party_games_app/features/games/domain/repository/remote_games_source.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_uid.dart';

class RestGameDatabase implements RemoteGamesDataSource {
  late final Future<String> uidGetter;
  String? uid;

  RestGameDatabase(GetUIDUseCase getUIDUseCase) {
    uidGetter = getUIDUseCase.call();
  }
  
  @override
  Future<DataState<List<Game>>> getGames() async {
    uid = await uidGetter;
    try {
      var response = await http.get(
          Uri.http('$serverDomain:$serverHttpPort', gamesPath),
          headers: <String, String>{
            'Authorization': 'Bearer $uid'
          }).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        var games = (jsonResponse['games'] as List?)
                ?.map((game) => PublishedGameModel.fromJson(game).toEntity())
                .toList() ??
            [];
        return DataSuccess(games);
      } else {
        return DataFailed(
            'Ошибка при получении списка игр: ${response.statusCode}.');
      }
    } catch (e) {
      return const DataFailed('Сервер недоступен');
    }
  }
}
