// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_table.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Todo extends DataClass implements Insertable<Todo> {
  final int? id;
  final String title;
  final String? content;
  final int? category;
  final DateTime? createdTime;
  final DateTime dueTime;
  final DateTime? completedTime;
  final bool? isCompleted;
  Todo(
      {this.id,
      required this.title,
      this.content,
      this.category,
      this.createdTime,
      required this.dueTime,
      this.completedTime,
      this.isCompleted});
  factory Todo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Todo(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      createdTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_time']),
      dueTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}due_time'])!,
      completedTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}completedTime']),
      isCompleted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_completed']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    if (!nullToAbsent || createdTime != null) {
      map['created_time'] = Variable<DateTime?>(createdTime);
    }
    map['due_time'] = Variable<DateTime>(dueTime);
    if (!nullToAbsent || completedTime != null) {
      map['completedTime'] = Variable<DateTime?>(completedTime);
    }
    if (!nullToAbsent || isCompleted != null) {
      map['is_completed'] = Variable<bool?>(isCompleted);
    }
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title: Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      createdTime: createdTime == null && nullToAbsent
          ? const Value.absent()
          : Value(createdTime),
      dueTime: Value(dueTime),
      completedTime: completedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(completedTime),
      isCompleted: isCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isCompleted),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int?>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      category: serializer.fromJson<int?>(json['category']),
      createdTime: serializer.fromJson<DateTime?>(json['createdTime']),
      dueTime: serializer.fromJson<DateTime>(json['dueTime']),
      completedTime: serializer.fromJson<DateTime?>(json['completedTime']),
      isCompleted: serializer.fromJson<bool?>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String?>(content),
      'category': serializer.toJson<int?>(category),
      'createdTime': serializer.toJson<DateTime?>(createdTime),
      'dueTime': serializer.toJson<DateTime>(dueTime),
      'completedTime': serializer.toJson<DateTime?>(completedTime),
      'isCompleted': serializer.toJson<bool?>(isCompleted),
    };
  }

  Todo copyWith(
          {int? id,
          String? title,
          String? content,
          int? category,
          DateTime? createdTime,
          DateTime? dueTime,
          DateTime? completedTime,
          bool? isCompleted}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        category: category ?? this.category,
        createdTime: createdTime ?? this.createdTime,
        dueTime: dueTime ?? this.dueTime,
        completedTime: completedTime ?? this.completedTime,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('createdTime: $createdTime, ')
          ..write('dueTime: $dueTime, ')
          ..write('completedTime: $completedTime, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, category, createdTime,
      dueTime, completedTime, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.category == this.category &&
          other.createdTime == this.createdTime &&
          other.dueTime == this.dueTime &&
          other.completedTime == this.completedTime &&
          other.isCompleted == this.isCompleted);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int?> id;
  final Value<String> title;
  final Value<String?> content;
  final Value<int?> category;
  final Value<DateTime?> createdTime;
  final Value<DateTime> dueTime;
  final Value<DateTime?> completedTime;
  final Value<bool?> isCompleted;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
    this.createdTime = const Value.absent(),
    this.dueTime = const Value.absent(),
    this.completedTime = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.content = const Value.absent(),
    this.category = const Value.absent(),
    this.createdTime = const Value.absent(),
    required DateTime dueTime,
    this.completedTime = const Value.absent(),
    this.isCompleted = const Value.absent(),
  })  : title = Value(title),
        dueTime = Value(dueTime);
  static Insertable<Todo> custom({
    Expression<int?>? id,
    Expression<String>? title,
    Expression<String?>? content,
    Expression<int?>? category,
    Expression<DateTime?>? createdTime,
    Expression<DateTime>? dueTime,
    Expression<DateTime?>? completedTime,
    Expression<bool?>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (category != null) 'category': category,
      if (createdTime != null) 'created_time': createdTime,
      if (dueTime != null) 'due_time': dueTime,
      if (completedTime != null) 'completedTime': completedTime,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  TodosCompanion copyWith(
      {Value<int?>? id,
      Value<String>? title,
      Value<String?>? content,
      Value<int?>? category,
      Value<DateTime?>? createdTime,
      Value<DateTime>? dueTime,
      Value<DateTime?>? completedTime,
      Value<bool?>? isCompleted}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdTime: createdTime ?? this.createdTime,
      dueTime: dueTime ?? this.dueTime,
      completedTime: completedTime ?? this.completedTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
    }
    if (createdTime.present) {
      map['created_time'] = Variable<DateTime?>(createdTime.value);
    }
    if (dueTime.present) {
      map['due_time'] = Variable<DateTime>(dueTime.value);
    }
    if (completedTime.present) {
      map['completedTime'] = Variable<DateTime?>(completedTime.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool?>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('createdTime: $createdTime, ')
          ..write('dueTime: $dueTime, ')
          ..write('completedTime: $completedTime, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TodosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _createdTimeMeta =
      const VerificationMeta('createdTime');
  @override
  late final GeneratedColumn<DateTime?> createdTime =
      GeneratedColumn<DateTime?>('created_time', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dueTimeMeta = const VerificationMeta('dueTime');
  @override
  late final GeneratedColumn<DateTime?> dueTime = GeneratedColumn<DateTime?>(
      'due_time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _completedTimeMeta =
      const VerificationMeta('completedTime');
  @override
  late final GeneratedColumn<DateTime?> completedTime =
      GeneratedColumn<DateTime?>('completedTime', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool?> isCompleted = GeneratedColumn<bool?>(
      'is_completed', aliasedName, true,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_completed IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        content,
        category,
        createdTime,
        dueTime,
        completedTime,
        isCompleted
      ];
  @override
  String get aliasedName => _alias ?? 'todos';
  @override
  String get actualTableName => 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('created_time')) {
      context.handle(
          _createdTimeMeta,
          createdTime.isAcceptableOrUnknown(
              data['created_time']!, _createdTimeMeta));
    }
    if (data.containsKey('due_time')) {
      context.handle(_dueTimeMeta,
          dueTime.isAcceptableOrUnknown(data['due_time']!, _dueTimeMeta));
    } else if (isInserting) {
      context.missing(_dueTimeMeta);
    }
    if (data.containsKey('completedTime')) {
      context.handle(
          _completedTimeMeta,
          completedTime.isAcceptableOrUnknown(
              data['completedTime']!, _completedTimeMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Todo.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodosTable todos = $TodosTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}
