import 'package:synchronized/synchronized.dart';

class SyncCounter {
  int _count = 0;
  final Lock _lock = Lock();

  Future<int> get newId async {
    return _lock.synchronized(() {
      _count++;
      return _count;
    });
  }
}
