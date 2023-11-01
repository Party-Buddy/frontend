// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BaseTaskDao? _baseTaskDaoInstance;

  CheckedTextTaskDao? _checkedTextTaskDaoInstance;

  LocalGameDao? _gameDaoInstance;

  TaskBindingDao? _taskBindingDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `games` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `description` TEXT NOT NULL, `name` TEXT NOT NULL, `imageUri` TEXT, `createdAt` INTEGER NOT NULL, `updatedAt` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `imageUri` TEXT, `duration` INTEGER NOT NULL, `type` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `checked_text_task` (`base_task_id` INTEGER NOT NULL, `answer` TEXT NOT NULL, FOREIGN KEY (`base_task_id`) REFERENCES `task` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`base_task_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `task_bindings` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `game_id` INTEGER NOT NULL, `base_task_id` INTEGER NOT NULL, FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`base_task_id`) REFERENCES `task` (`id`) ON UPDATE NO ACTION ON DELETE RESTRICT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BaseTaskDao get baseTaskDao {
    return _baseTaskDaoInstance ??= _$BaseTaskDao(database, changeListener);
  }

  @override
  CheckedTextTaskDao get checkedTextTaskDao {
    return _checkedTextTaskDaoInstance ??=
        _$CheckedTextTaskDao(database, changeListener);
  }

  @override
  LocalGameDao get gameDao {
    return _gameDaoInstance ??= _$LocalGameDao(database, changeListener);
  }

  @override
  TaskBindingDao get taskBindingDao {
    return _taskBindingDaoInstance ??=
        _$TaskBindingDao(database, changeListener);
  }
}

class _$BaseTaskDao extends BaseTaskDao {
  _$BaseTaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _baseTaskModelInsertionAdapter = InsertionAdapter(
            database,
            'task',
            (BaseTaskModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'imageUri': item.imageUri,
                  'duration': item.duration,
                  'type': item.type.index
                }),
        _baseTaskModelDeletionAdapter = DeletionAdapter(
            database,
            'task',
            ['id'],
            (BaseTaskModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'imageUri': item.imageUri,
                  'duration': item.duration,
                  'type': item.type.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BaseTaskModel> _baseTaskModelInsertionAdapter;

  final DeletionAdapter<BaseTaskModel> _baseTaskModelDeletionAdapter;

  @override
  Future<List<BaseTaskModel>> getBaseTasks() async {
    return _queryAdapter.queryList('SELECT * FROM task',
        mapper: (Map<String, Object?> row) => BaseTaskModel(
            id: row['id'] as int,
            name: row['name'] as String,
            description: row['description'] as String,
            imageUri: row['imageUri'] as String?,
            duration: row['duration'] as int,
            type: TaskTypes.values[row['type'] as int]));
  }

  @override
  Future<void> insertBaseTask(BaseTaskModel taskModel) async {
    await _baseTaskModelInsertionAdapter.insert(
        taskModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBaseTask(BaseTaskModel taskModel) async {
    await _baseTaskModelDeletionAdapter.delete(taskModel);
  }
}

class _$CheckedTextTaskDao extends CheckedTextTaskDao {
  _$CheckedTextTaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _checkedTextTaskModelInsertionAdapter = InsertionAdapter(
            database,
            'checked_text_task',
            (CheckedTextTaskModel item) => <String, Object?>{
                  'base_task_id': item.baseTaskId,
                  'answer': item.answer
                }),
        _checkedTextTaskModelDeletionAdapter = DeletionAdapter(
            database,
            'checked_text_task',
            ['base_task_id'],
            (CheckedTextTaskModel item) => <String, Object?>{
                  'base_task_id': item.baseTaskId,
                  'answer': item.answer
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CheckedTextTaskModel>
      _checkedTextTaskModelInsertionAdapter;

  final DeletionAdapter<CheckedTextTaskModel>
      _checkedTextTaskModelDeletionAdapter;

  @override
  Future<List<CheckedTextTaskModel>> getCheckedTextTasks() async {
    return _queryAdapter.queryList('SELECT * FROM checked_text_task',
        mapper: (Map<String, Object?> row) => CheckedTextTaskModel(
            baseTaskId: row['base_task_id'] as int,
            answer: row['answer'] as String));
  }

  @override
  Future<void> insertCheckedTextTask(CheckedTextTaskModel taskModel) async {
    await _checkedTextTaskModelInsertionAdapter.insert(
        taskModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCheckedTextTask(CheckedTextTaskModel taskModel) async {
    await _checkedTextTaskModelDeletionAdapter.delete(taskModel);
  }
}

class _$LocalGameDao extends LocalGameDao {
  _$LocalGameDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _localGameModelInsertionAdapter = InsertionAdapter(
            database,
            'games',
            (LocalGameModel item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'name': item.name,
                  'imageUri': item.imageUri,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _localGameModelDeletionAdapter = DeletionAdapter(
            database,
            'games',
            ['id'],
            (LocalGameModel item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'name': item.name,
                  'imageUri': item.imageUri,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LocalGameModel> _localGameModelInsertionAdapter;

  final DeletionAdapter<LocalGameModel> _localGameModelDeletionAdapter;

  @override
  Future<List<LocalGameModel>> getGames() async {
    return _queryAdapter.queryList('SELECT * FROM games',
        mapper: (Map<String, Object?> row) => LocalGameModel(
            id: row['id'] as int,
            name: row['name'] as String,
            description: row['description'] as String,
            imageUri: row['imageUri'] as String?,
            createdAt: row['createdAt'] as int,
            updatedAt: row['updatedAt'] as int));
  }

  @override
  Future<void> insertGame(LocalGameModel gameModel) async {
    await _localGameModelInsertionAdapter.insert(
        gameModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteGame(LocalGameModel gameModel) async {
    await _localGameModelDeletionAdapter.delete(gameModel);
  }
}

class _$TaskBindingDao extends TaskBindingDao {
  _$TaskBindingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskBindingInsertionAdapter = InsertionAdapter(
            database,
            'task_bindings',
            (TaskBinding item) => <String, Object?>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'base_task_id': item.baseTaskId
                }),
        _taskBindingDeletionAdapter = DeletionAdapter(
            database,
            'task_bindings',
            ['id'],
            (TaskBinding item) => <String, Object?>{
                  'id': item.id,
                  'game_id': item.gameId,
                  'base_task_id': item.baseTaskId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskBinding> _taskBindingInsertionAdapter;

  final DeletionAdapter<TaskBinding> _taskBindingDeletionAdapter;

  @override
  Future<List<TaskBinding>> getBindings() async {
    return _queryAdapter.queryList('SELECT * FROM task_bindings',
        mapper: (Map<String, Object?> row) => TaskBinding(
            id: row['id'] as int,
            gameId: row['game_id'] as int,
            baseTaskId: row['base_task_id'] as int));
  }

  @override
  Future<void> insertBinding(TaskBinding binding) async {
    await _taskBindingInsertionAdapter.insert(
        binding, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBinding(TaskBinding binding) async {
    await _taskBindingDeletionAdapter.delete(binding);
  }
}
