import 'package:party_games_app/core/resources/data_state.dart';

Future<DataState<List<T>>> convertFuture<T>(Future<List<T>> future) async {
  return future.then((list) {
    return DataSuccess<List<T>>(list);
  });
}

Future<DataState<List<T>>> convertFutureDataState<T>(
    Future<DataState<List<T>>> future) async {
  return future.then((list) {
    return list;
  });
}
