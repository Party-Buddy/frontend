// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class LocalGame extends DataClass implements Insertable<LocalGame> {
  final int id;
  final String name;
  final String? description;
  final String? imageUri;
  final DateTime createdAt;
  final DateTime updatedAt;
  LocalGame(
      {required this.id,
      required this.name,
      this.description,
      this.imageUri,
      required this.createdAt,
      required this.updatedAt});
  factory LocalGame.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalGame(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      imageUri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_uri']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || imageUri != null) {
      map['image_uri'] = Variable<String?>(imageUri);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalGamesCompanion toCompanion(bool nullToAbsent) {
    return LocalGamesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageUri: imageUri == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUri),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalGame.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalGame(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      imageUri: serializer.fromJson<String?>(json['imageUri']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'imageUri': serializer.toJson<String?>(imageUri),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalGame copyWith(
          {int? id,
          String? name,
          String? description,
          String? imageUri,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalGame(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUri: imageUri ?? this.imageUri,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('LocalGame(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUri: $imageUri, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, imageUri, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalGame &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUri == this.imageUri &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalGamesCompanion extends UpdateCompanion<LocalGame> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> imageUri;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LocalGamesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUri = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocalGamesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.imageUri = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LocalGame> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String?>? description,
    Expression<String?>? imageUri,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUri != null) 'image_uri': imageUri,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocalGamesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? imageUri,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return LocalGamesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUri: imageUri ?? this.imageUri,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (imageUri.present) {
      map['image_uri'] = Variable<String?>(imageUri.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalGamesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUri: $imageUri, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LocalGamesTable extends LocalGames
    with TableInfo<$LocalGamesTable, LocalGame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalGamesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _imageUriMeta = const VerificationMeta('imageUri');
  @override
  late final GeneratedColumn<String?> imageUri = GeneratedColumn<String?>(
      'image_uri', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, imageUri, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'local_games';
  @override
  String get actualTableName => 'local_games';
  @override
  VerificationContext validateIntegrity(Insertable<LocalGame> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_uri')) {
      context.handle(_imageUriMeta,
          imageUri.isAcceptableOrUnknown(data['image_uri']!, _imageUriMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalGame map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalGame.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalGamesTable createAlias(String alias) {
    return $LocalGamesTable(attachedDatabase, alias);
  }
}

class LocalBaseTask extends DataClass implements Insertable<LocalBaseTask> {
  final int id;
  final String name;
  final String description;
  final String? imageUri;
  final int duration;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  LocalBaseTask(
      {required this.id,
      required this.name,
      required this.description,
      this.imageUri,
      required this.duration,
      required this.type,
      required this.createdAt,
      required this.updatedAt});
  factory LocalBaseTask.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalBaseTask(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      imageUri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_uri']),
      duration: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || imageUri != null) {
      map['image_uri'] = Variable<String?>(imageUri);
    }
    map['duration'] = Variable<int>(duration);
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BaseTasksCompanion toCompanion(bool nullToAbsent) {
    return BaseTasksCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      imageUri: imageUri == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUri),
      duration: Value(duration),
      type: Value(type),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalBaseTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalBaseTask(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      imageUri: serializer.fromJson<String?>(json['imageUri']),
      duration: serializer.fromJson<int>(json['duration']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'imageUri': serializer.toJson<String?>(imageUri),
      'duration': serializer.toJson<int>(duration),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalBaseTask copyWith(
          {int? id,
          String? name,
          String? description,
          String? imageUri,
          int? duration,
          String? type,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalBaseTask(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUri: imageUri ?? this.imageUri,
        duration: duration ?? this.duration,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('LocalBaseTask(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUri: $imageUri, ')
          ..write('duration: $duration, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, description, imageUri, duration, type, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalBaseTask &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUri == this.imageUri &&
          other.duration == this.duration &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BaseTasksCompanion extends UpdateCompanion<LocalBaseTask> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> imageUri;
  final Value<int> duration;
  final Value<String> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BaseTasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUri = const Value.absent(),
    this.duration = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BaseTasksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.imageUri = const Value.absent(),
    required int duration,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : name = Value(name),
        description = Value(description),
        duration = Value(duration),
        type = Value(type),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LocalBaseTask> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String?>? imageUri,
    Expression<int>? duration,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUri != null) 'image_uri': imageUri,
      if (duration != null) 'duration': duration,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BaseTasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String?>? imageUri,
      Value<int>? duration,
      Value<String>? type,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BaseTasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUri: imageUri ?? this.imageUri,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUri.present) {
      map['image_uri'] = Variable<String?>(imageUri.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BaseTasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUri: $imageUri, ')
          ..write('duration: $duration, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BaseTasksTable extends BaseTasks
    with TableInfo<$BaseTasksTable, LocalBaseTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BaseTasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _imageUriMeta = const VerificationMeta('imageUri');
  @override
  late final GeneratedColumn<String?> imageUri = GeneratedColumn<String?>(
      'image_uri', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int?> duration = GeneratedColumn<int?>(
      'duration', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, imageUri, duration, type, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'base_tasks';
  @override
  String get actualTableName => 'base_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<LocalBaseTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_uri')) {
      context.handle(_imageUriMeta,
          imageUri.isAcceptableOrUnknown(data['image_uri']!, _imageUriMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalBaseTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalBaseTask.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BaseTasksTable createAlias(String alias) {
    return $BaseTasksTable(attachedDatabase, alias);
  }
}

class LocalCheckedTextTask extends DataClass
    implements Insertable<LocalCheckedTextTask> {
  final int baseTaskId;
  final String answer;
  LocalCheckedTextTask({required this.baseTaskId, required this.answer});
  factory LocalCheckedTextTask.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalCheckedTextTask(
      baseTaskId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}base_task_id'])!,
      answer: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}answer'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['base_task_id'] = Variable<int>(baseTaskId);
    map['answer'] = Variable<String>(answer);
    return map;
  }

  CheckedTextTasksCompanion toCompanion(bool nullToAbsent) {
    return CheckedTextTasksCompanion(
      baseTaskId: Value(baseTaskId),
      answer: Value(answer),
    );
  }

  factory LocalCheckedTextTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalCheckedTextTask(
      baseTaskId: serializer.fromJson<int>(json['baseTaskId']),
      answer: serializer.fromJson<String>(json['answer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'baseTaskId': serializer.toJson<int>(baseTaskId),
      'answer': serializer.toJson<String>(answer),
    };
  }

  LocalCheckedTextTask copyWith({int? baseTaskId, String? answer}) =>
      LocalCheckedTextTask(
        baseTaskId: baseTaskId ?? this.baseTaskId,
        answer: answer ?? this.answer,
      );
  @override
  String toString() {
    return (StringBuffer('LocalCheckedTextTask(')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('answer: $answer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(baseTaskId, answer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCheckedTextTask &&
          other.baseTaskId == this.baseTaskId &&
          other.answer == this.answer);
}

class CheckedTextTasksCompanion extends UpdateCompanion<LocalCheckedTextTask> {
  final Value<int> baseTaskId;
  final Value<String> answer;
  const CheckedTextTasksCompanion({
    this.baseTaskId = const Value.absent(),
    this.answer = const Value.absent(),
  });
  CheckedTextTasksCompanion.insert({
    this.baseTaskId = const Value.absent(),
    required String answer,
  }) : answer = Value(answer);
  static Insertable<LocalCheckedTextTask> custom({
    Expression<int>? baseTaskId,
    Expression<String>? answer,
  }) {
    return RawValuesInsertable({
      if (baseTaskId != null) 'base_task_id': baseTaskId,
      if (answer != null) 'answer': answer,
    });
  }

  CheckedTextTasksCompanion copyWith(
      {Value<int>? baseTaskId, Value<String>? answer}) {
    return CheckedTextTasksCompanion(
      baseTaskId: baseTaskId ?? this.baseTaskId,
      answer: answer ?? this.answer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (baseTaskId.present) {
      map['base_task_id'] = Variable<int>(baseTaskId.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckedTextTasksCompanion(')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('answer: $answer')
          ..write(')'))
        .toString();
  }
}

class $CheckedTextTasksTable extends CheckedTextTasks
    with TableInfo<$CheckedTextTasksTable, LocalCheckedTextTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckedTextTasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _baseTaskIdMeta = const VerificationMeta('baseTaskId');
  @override
  late final GeneratedColumn<int?> baseTaskId = GeneratedColumn<int?>(
      'base_task_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES base_tasks (id) ON DELETE CASCADE');
  final VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String?> answer = GeneratedColumn<String?>(
      'answer', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [baseTaskId, answer];
  @override
  String get aliasedName => _alias ?? 'checked_text_tasks';
  @override
  String get actualTableName => 'checked_text_tasks';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalCheckedTextTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('base_task_id')) {
      context.handle(
          _baseTaskIdMeta,
          baseTaskId.isAcceptableOrUnknown(
              data['base_task_id']!, _baseTaskIdMeta));
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta,
          answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {baseTaskId};
  @override
  LocalCheckedTextTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalCheckedTextTask.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CheckedTextTasksTable createAlias(String alias) {
    return $CheckedTextTasksTable(attachedDatabase, alias);
  }
}

class TaskBinding extends DataClass implements Insertable<TaskBinding> {
  final int gameOrder;
  final int baseTaskId;
  final int gameId;
  TaskBinding(
      {required this.gameOrder,
      required this.baseTaskId,
      required this.gameId});
  factory TaskBinding.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TaskBinding(
      gameOrder: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}game_order'])!,
      baseTaskId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}base_task_id'])!,
      gameId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}game_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['game_order'] = Variable<int>(gameOrder);
    map['base_task_id'] = Variable<int>(baseTaskId);
    map['game_id'] = Variable<int>(gameId);
    return map;
  }

  TaskBindingsCompanion toCompanion(bool nullToAbsent) {
    return TaskBindingsCompanion(
      gameOrder: Value(gameOrder),
      baseTaskId: Value(baseTaskId),
      gameId: Value(gameId),
    );
  }

  factory TaskBinding.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TaskBinding(
      gameOrder: serializer.fromJson<int>(json['gameOrder']),
      baseTaskId: serializer.fromJson<int>(json['baseTaskId']),
      gameId: serializer.fromJson<int>(json['gameId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gameOrder': serializer.toJson<int>(gameOrder),
      'baseTaskId': serializer.toJson<int>(baseTaskId),
      'gameId': serializer.toJson<int>(gameId),
    };
  }

  TaskBinding copyWith({int? gameOrder, int? baseTaskId, int? gameId}) =>
      TaskBinding(
        gameOrder: gameOrder ?? this.gameOrder,
        baseTaskId: baseTaskId ?? this.baseTaskId,
        gameId: gameId ?? this.gameId,
      );
  @override
  String toString() {
    return (StringBuffer('TaskBinding(')
          ..write('gameOrder: $gameOrder, ')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('gameId: $gameId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(gameOrder, baseTaskId, gameId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskBinding &&
          other.gameOrder == this.gameOrder &&
          other.baseTaskId == this.baseTaskId &&
          other.gameId == this.gameId);
}

class TaskBindingsCompanion extends UpdateCompanion<TaskBinding> {
  final Value<int> gameOrder;
  final Value<int> baseTaskId;
  final Value<int> gameId;
  const TaskBindingsCompanion({
    this.gameOrder = const Value.absent(),
    this.baseTaskId = const Value.absent(),
    this.gameId = const Value.absent(),
  });
  TaskBindingsCompanion.insert({
    required int gameOrder,
    required int baseTaskId,
    required int gameId,
  })  : gameOrder = Value(gameOrder),
        baseTaskId = Value(baseTaskId),
        gameId = Value(gameId);
  static Insertable<TaskBinding> custom({
    Expression<int>? gameOrder,
    Expression<int>? baseTaskId,
    Expression<int>? gameId,
  }) {
    return RawValuesInsertable({
      if (gameOrder != null) 'game_order': gameOrder,
      if (baseTaskId != null) 'base_task_id': baseTaskId,
      if (gameId != null) 'game_id': gameId,
    });
  }

  TaskBindingsCompanion copyWith(
      {Value<int>? gameOrder, Value<int>? baseTaskId, Value<int>? gameId}) {
    return TaskBindingsCompanion(
      gameOrder: gameOrder ?? this.gameOrder,
      baseTaskId: baseTaskId ?? this.baseTaskId,
      gameId: gameId ?? this.gameId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gameOrder.present) {
      map['game_order'] = Variable<int>(gameOrder.value);
    }
    if (baseTaskId.present) {
      map['base_task_id'] = Variable<int>(baseTaskId.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskBindingsCompanion(')
          ..write('gameOrder: $gameOrder, ')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('gameId: $gameId')
          ..write(')'))
        .toString();
  }
}

class $TaskBindingsTable extends TaskBindings
    with TableInfo<$TaskBindingsTable, TaskBinding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskBindingsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _gameOrderMeta = const VerificationMeta('gameOrder');
  @override
  late final GeneratedColumn<int?> gameOrder = GeneratedColumn<int?>(
      'game_order', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _baseTaskIdMeta = const VerificationMeta('baseTaskId');
  @override
  late final GeneratedColumn<int?> baseTaskId = GeneratedColumn<int?>(
      'base_task_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES base_tasks (id) ON DELETE RESTRICT');
  final VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int?> gameId = GeneratedColumn<int?>(
      'game_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES local_games (id) ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [gameOrder, baseTaskId, gameId];
  @override
  String get aliasedName => _alias ?? 'task_bindings';
  @override
  String get actualTableName => 'task_bindings';
  @override
  VerificationContext validateIntegrity(Insertable<TaskBinding> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('game_order')) {
      context.handle(_gameOrderMeta,
          gameOrder.isAcceptableOrUnknown(data['game_order']!, _gameOrderMeta));
    } else if (isInserting) {
      context.missing(_gameOrderMeta);
    }
    if (data.containsKey('base_task_id')) {
      context.handle(
          _baseTaskIdMeta,
          baseTaskId.isAcceptableOrUnknown(
              data['base_task_id']!, _baseTaskIdMeta));
    } else if (isInserting) {
      context.missing(_baseTaskIdMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(_gameIdMeta,
          gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta));
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gameId, gameOrder};
  @override
  TaskBinding map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TaskBinding.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TaskBindingsTable createAlias(String alias) {
    return $TaskBindingsTable(attachedDatabase, alias);
  }
}

class LocalPollTask extends DataClass implements Insertable<LocalPollTask> {
  final int baseTaskId;
  final String pollAnswerType;
  final int pollFixedDuration;
  final int pollDynamicDuration;
  LocalPollTask(
      {required this.baseTaskId,
      required this.pollAnswerType,
      required this.pollFixedDuration,
      required this.pollDynamicDuration});
  factory LocalPollTask.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalPollTask(
      baseTaskId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}base_task_id'])!,
      pollAnswerType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}poll_answer_type'])!,
      pollFixedDuration: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}poll_fixed_duration'])!,
      pollDynamicDuration: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}poll_dynamic_duration'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['base_task_id'] = Variable<int>(baseTaskId);
    map['poll_answer_type'] = Variable<String>(pollAnswerType);
    map['poll_fixed_duration'] = Variable<int>(pollFixedDuration);
    map['poll_dynamic_duration'] = Variable<int>(pollDynamicDuration);
    return map;
  }

  PollTasksCompanion toCompanion(bool nullToAbsent) {
    return PollTasksCompanion(
      baseTaskId: Value(baseTaskId),
      pollAnswerType: Value(pollAnswerType),
      pollFixedDuration: Value(pollFixedDuration),
      pollDynamicDuration: Value(pollDynamicDuration),
    );
  }

  factory LocalPollTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalPollTask(
      baseTaskId: serializer.fromJson<int>(json['baseTaskId']),
      pollAnswerType: serializer.fromJson<String>(json['pollAnswerType']),
      pollFixedDuration: serializer.fromJson<int>(json['pollFixedDuration']),
      pollDynamicDuration:
          serializer.fromJson<int>(json['pollDynamicDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'baseTaskId': serializer.toJson<int>(baseTaskId),
      'pollAnswerType': serializer.toJson<String>(pollAnswerType),
      'pollFixedDuration': serializer.toJson<int>(pollFixedDuration),
      'pollDynamicDuration': serializer.toJson<int>(pollDynamicDuration),
    };
  }

  LocalPollTask copyWith(
          {int? baseTaskId,
          String? pollAnswerType,
          int? pollFixedDuration,
          int? pollDynamicDuration}) =>
      LocalPollTask(
        baseTaskId: baseTaskId ?? this.baseTaskId,
        pollAnswerType: pollAnswerType ?? this.pollAnswerType,
        pollFixedDuration: pollFixedDuration ?? this.pollFixedDuration,
        pollDynamicDuration: pollDynamicDuration ?? this.pollDynamicDuration,
      );
  @override
  String toString() {
    return (StringBuffer('LocalPollTask(')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('pollAnswerType: $pollAnswerType, ')
          ..write('pollFixedDuration: $pollFixedDuration, ')
          ..write('pollDynamicDuration: $pollDynamicDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      baseTaskId, pollAnswerType, pollFixedDuration, pollDynamicDuration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPollTask &&
          other.baseTaskId == this.baseTaskId &&
          other.pollAnswerType == this.pollAnswerType &&
          other.pollFixedDuration == this.pollFixedDuration &&
          other.pollDynamicDuration == this.pollDynamicDuration);
}

class PollTasksCompanion extends UpdateCompanion<LocalPollTask> {
  final Value<int> baseTaskId;
  final Value<String> pollAnswerType;
  final Value<int> pollFixedDuration;
  final Value<int> pollDynamicDuration;
  const PollTasksCompanion({
    this.baseTaskId = const Value.absent(),
    this.pollAnswerType = const Value.absent(),
    this.pollFixedDuration = const Value.absent(),
    this.pollDynamicDuration = const Value.absent(),
  });
  PollTasksCompanion.insert({
    this.baseTaskId = const Value.absent(),
    required String pollAnswerType,
    required int pollFixedDuration,
    required int pollDynamicDuration,
  })  : pollAnswerType = Value(pollAnswerType),
        pollFixedDuration = Value(pollFixedDuration),
        pollDynamicDuration = Value(pollDynamicDuration);
  static Insertable<LocalPollTask> custom({
    Expression<int>? baseTaskId,
    Expression<String>? pollAnswerType,
    Expression<int>? pollFixedDuration,
    Expression<int>? pollDynamicDuration,
  }) {
    return RawValuesInsertable({
      if (baseTaskId != null) 'base_task_id': baseTaskId,
      if (pollAnswerType != null) 'poll_answer_type': pollAnswerType,
      if (pollFixedDuration != null) 'poll_fixed_duration': pollFixedDuration,
      if (pollDynamicDuration != null)
        'poll_dynamic_duration': pollDynamicDuration,
    });
  }

  PollTasksCompanion copyWith(
      {Value<int>? baseTaskId,
      Value<String>? pollAnswerType,
      Value<int>? pollFixedDuration,
      Value<int>? pollDynamicDuration}) {
    return PollTasksCompanion(
      baseTaskId: baseTaskId ?? this.baseTaskId,
      pollAnswerType: pollAnswerType ?? this.pollAnswerType,
      pollFixedDuration: pollFixedDuration ?? this.pollFixedDuration,
      pollDynamicDuration: pollDynamicDuration ?? this.pollDynamicDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (baseTaskId.present) {
      map['base_task_id'] = Variable<int>(baseTaskId.value);
    }
    if (pollAnswerType.present) {
      map['poll_answer_type'] = Variable<String>(pollAnswerType.value);
    }
    if (pollFixedDuration.present) {
      map['poll_fixed_duration'] = Variable<int>(pollFixedDuration.value);
    }
    if (pollDynamicDuration.present) {
      map['poll_dynamic_duration'] = Variable<int>(pollDynamicDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PollTasksCompanion(')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('pollAnswerType: $pollAnswerType, ')
          ..write('pollFixedDuration: $pollFixedDuration, ')
          ..write('pollDynamicDuration: $pollDynamicDuration')
          ..write(')'))
        .toString();
  }
}

class $PollTasksTable extends PollTasks
    with TableInfo<$PollTasksTable, LocalPollTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PollTasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _baseTaskIdMeta = const VerificationMeta('baseTaskId');
  @override
  late final GeneratedColumn<int?> baseTaskId = GeneratedColumn<int?>(
      'base_task_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES base_tasks (id) ON DELETE CASCADE');
  final VerificationMeta _pollAnswerTypeMeta =
      const VerificationMeta('pollAnswerType');
  @override
  late final GeneratedColumn<String?> pollAnswerType = GeneratedColumn<String?>(
      'poll_answer_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pollFixedDurationMeta =
      const VerificationMeta('pollFixedDuration');
  @override
  late final GeneratedColumn<int?> pollFixedDuration = GeneratedColumn<int?>(
      'poll_fixed_duration', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _pollDynamicDurationMeta =
      const VerificationMeta('pollDynamicDuration');
  @override
  late final GeneratedColumn<int?> pollDynamicDuration = GeneratedColumn<int?>(
      'poll_dynamic_duration', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [baseTaskId, pollAnswerType, pollFixedDuration, pollDynamicDuration];
  @override
  String get aliasedName => _alias ?? 'poll_tasks';
  @override
  String get actualTableName => 'poll_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<LocalPollTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('base_task_id')) {
      context.handle(
          _baseTaskIdMeta,
          baseTaskId.isAcceptableOrUnknown(
              data['base_task_id']!, _baseTaskIdMeta));
    }
    if (data.containsKey('poll_answer_type')) {
      context.handle(
          _pollAnswerTypeMeta,
          pollAnswerType.isAcceptableOrUnknown(
              data['poll_answer_type']!, _pollAnswerTypeMeta));
    } else if (isInserting) {
      context.missing(_pollAnswerTypeMeta);
    }
    if (data.containsKey('poll_fixed_duration')) {
      context.handle(
          _pollFixedDurationMeta,
          pollFixedDuration.isAcceptableOrUnknown(
              data['poll_fixed_duration']!, _pollFixedDurationMeta));
    } else if (isInserting) {
      context.missing(_pollFixedDurationMeta);
    }
    if (data.containsKey('poll_dynamic_duration')) {
      context.handle(
          _pollDynamicDurationMeta,
          pollDynamicDuration.isAcceptableOrUnknown(
              data['poll_dynamic_duration']!, _pollDynamicDurationMeta));
    } else if (isInserting) {
      context.missing(_pollDynamicDurationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {baseTaskId};
  @override
  LocalPollTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalPollTask.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PollTasksTable createAlias(String alias) {
    return $PollTasksTable(attachedDatabase, alias);
  }
}

class LocalChoiceTaskOption extends DataClass
    implements Insertable<LocalChoiceTaskOption> {
  final int id;
  final int baseTaskId;
  final String answer;
  final bool correct;
  LocalChoiceTaskOption(
      {required this.id,
      required this.baseTaskId,
      required this.answer,
      required this.correct});
  factory LocalChoiceTaskOption.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalChoiceTaskOption(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      baseTaskId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}base_task_id'])!,
      answer: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}answer'])!,
      correct: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}correct'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['base_task_id'] = Variable<int>(baseTaskId);
    map['answer'] = Variable<String>(answer);
    map['correct'] = Variable<bool>(correct);
    return map;
  }

  ChoiceTaskOptionsCompanion toCompanion(bool nullToAbsent) {
    return ChoiceTaskOptionsCompanion(
      id: Value(id),
      baseTaskId: Value(baseTaskId),
      answer: Value(answer),
      correct: Value(correct),
    );
  }

  factory LocalChoiceTaskOption.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalChoiceTaskOption(
      id: serializer.fromJson<int>(json['id']),
      baseTaskId: serializer.fromJson<int>(json['baseTaskId']),
      answer: serializer.fromJson<String>(json['answer']),
      correct: serializer.fromJson<bool>(json['correct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'baseTaskId': serializer.toJson<int>(baseTaskId),
      'answer': serializer.toJson<String>(answer),
      'correct': serializer.toJson<bool>(correct),
    };
  }

  LocalChoiceTaskOption copyWith(
          {int? id, int? baseTaskId, String? answer, bool? correct}) =>
      LocalChoiceTaskOption(
        id: id ?? this.id,
        baseTaskId: baseTaskId ?? this.baseTaskId,
        answer: answer ?? this.answer,
        correct: correct ?? this.correct,
      );
  @override
  String toString() {
    return (StringBuffer('LocalChoiceTaskOption(')
          ..write('id: $id, ')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('answer: $answer, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, baseTaskId, answer, correct);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalChoiceTaskOption &&
          other.id == this.id &&
          other.baseTaskId == this.baseTaskId &&
          other.answer == this.answer &&
          other.correct == this.correct);
}

class ChoiceTaskOptionsCompanion
    extends UpdateCompanion<LocalChoiceTaskOption> {
  final Value<int> id;
  final Value<int> baseTaskId;
  final Value<String> answer;
  final Value<bool> correct;
  const ChoiceTaskOptionsCompanion({
    this.id = const Value.absent(),
    this.baseTaskId = const Value.absent(),
    this.answer = const Value.absent(),
    this.correct = const Value.absent(),
  });
  ChoiceTaskOptionsCompanion.insert({
    this.id = const Value.absent(),
    required int baseTaskId,
    required String answer,
    required bool correct,
  })  : baseTaskId = Value(baseTaskId),
        answer = Value(answer),
        correct = Value(correct);
  static Insertable<LocalChoiceTaskOption> custom({
    Expression<int>? id,
    Expression<int>? baseTaskId,
    Expression<String>? answer,
    Expression<bool>? correct,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseTaskId != null) 'base_task_id': baseTaskId,
      if (answer != null) 'answer': answer,
      if (correct != null) 'correct': correct,
    });
  }

  ChoiceTaskOptionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? baseTaskId,
      Value<String>? answer,
      Value<bool>? correct}) {
    return ChoiceTaskOptionsCompanion(
      id: id ?? this.id,
      baseTaskId: baseTaskId ?? this.baseTaskId,
      answer: answer ?? this.answer,
      correct: correct ?? this.correct,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (baseTaskId.present) {
      map['base_task_id'] = Variable<int>(baseTaskId.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (correct.present) {
      map['correct'] = Variable<bool>(correct.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChoiceTaskOptionsCompanion(')
          ..write('id: $id, ')
          ..write('baseTaskId: $baseTaskId, ')
          ..write('answer: $answer, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }
}

class $ChoiceTaskOptionsTable extends ChoiceTaskOptions
    with TableInfo<$ChoiceTaskOptionsTable, LocalChoiceTaskOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChoiceTaskOptionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _baseTaskIdMeta = const VerificationMeta('baseTaskId');
  @override
  late final GeneratedColumn<int?> baseTaskId = GeneratedColumn<int?>(
      'base_task_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES base_tasks (id) ON DELETE CASCADE');
  final VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String?> answer = GeneratedColumn<String?>(
      'answer', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _correctMeta = const VerificationMeta('correct');
  @override
  late final GeneratedColumn<bool?> correct = GeneratedColumn<bool?>(
      'correct', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (correct IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [id, baseTaskId, answer, correct];
  @override
  String get aliasedName => _alias ?? 'choice_task_options';
  @override
  String get actualTableName => 'choice_task_options';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalChoiceTaskOption> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('base_task_id')) {
      context.handle(
          _baseTaskIdMeta,
          baseTaskId.isAcceptableOrUnknown(
              data['base_task_id']!, _baseTaskIdMeta));
    } else if (isInserting) {
      context.missing(_baseTaskIdMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta,
          answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(_correctMeta,
          correct.isAcceptableOrUnknown(data['correct']!, _correctMeta));
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalChoiceTaskOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalChoiceTaskOption.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ChoiceTaskOptionsTable createAlias(String alias) {
    return $ChoiceTaskOptionsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $LocalGamesTable localGames = $LocalGamesTable(this);
  late final $BaseTasksTable baseTasks = $BaseTasksTable(this);
  late final $CheckedTextTasksTable checkedTextTasks =
      $CheckedTextTasksTable(this);
  late final $TaskBindingsTable taskBindings = $TaskBindingsTable(this);
  late final $PollTasksTable pollTasks = $PollTasksTable(this);
  late final $ChoiceTaskOptionsTable choiceTaskOptions =
      $ChoiceTaskOptionsTable(this);
  late final GameDao gameDao = GameDao(this as AppDatabase);
  late final TaskBindingDao taskBindingDao =
      TaskBindingDao(this as AppDatabase);
  late final BaseTaskDao baseTaskDao = BaseTaskDao(this as AppDatabase);
  late final CheckedTextTaskDao checkedTextTaskDao =
      CheckedTextTaskDao(this as AppDatabase);
  late final PollTaskDao pollTaskDao = PollTaskDao(this as AppDatabase);
  late final ChoiceTaskDao choiceTaskDao = ChoiceTaskDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        localGames,
        baseTasks,
        checkedTextTasks,
        taskBindings,
        pollTasks,
        choiceTaskOptions
      ];
}
