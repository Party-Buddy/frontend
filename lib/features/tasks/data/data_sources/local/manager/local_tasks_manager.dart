
/*class DatabaseManager {
  final AppDatabase _database;

  DatabaseManager(this._database);

  Future<List<TaskWithAdditionalInfo>> getAllTasksWithAdditionalInfo() async {
    final joinQuery = _database.taskDao.getAllTasksWithAdditionalInfo();
    final taskWithAdditionalInfoList = await joinQuery.map((rows) {
      final task = rows.task;
      final additionalInfo1 = rows.additionalInfo1;
      final additionalInfo2 = rows.additionalInfo2;
      return TaskWithAdditionalInfo(task, additionalInfo1, additionalInfo2);
    }).toList();
    return taskWithAdditionalInfoList;
  }
}
*/