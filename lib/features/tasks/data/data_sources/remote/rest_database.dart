import 'dart:convert';

import 'package:party_games_app/config/server/paths.dart';
import 'package:party_games_app/core/resources/data_state.dart';
import 'package:http/http.dart' as http;
import 'package:party_games_app/features/tasks/data/models/task_model.dart';
import 'package:party_games_app/features/tasks/domain/entities/task.dart';
import 'package:party_games_app/features/tasks/domain/repository/remote_tasks_source.dart';
import 'package:party_games_app/features/user_data/domain/usecases/get_uid.dart';

class RestTaskDatabase implements RemoteTasksDataSource {
  late final Future<String> uidGetter;
  String? uid;

  RestTaskDatabase(GetUIDUseCase getUIDUseCase) {
    uidGetter = getUIDUseCase.call();
  }

  @override
  Future<DataState<List<PublishedTask>>> getTasks() async {
    uid = await uidGetter;
    try {
      var response = await http.get(
          Uri.http('$serverDomain:$serverHttpPort', tasksPath),
          headers: <String, String>{
            'Authorization': 'Bearer $uid'
          }).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        var tasks = (jsonResponse['tasks'] as List?)
                ?.map((task) => PublishedTaskModel.fromJson(task).toEntity())
                .toList() ??
            [];
        return DataSuccess(tasks);
      } else {
        return DataFailed(
            'Ошибка при получении списка заданий: ${response.statusCode}.');
      }
    } catch (e) {
      return const DataFailed('Сервер недоступен');
    }
  }
}
