import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shzzz/data/database/todo_table.dart';

final _todo1 = Todo(
  id: 0,
  title: 'Testing1',
  dueTime: DateTime.now(),
);

final _todo2 = Todo(
  id: 1,
  title: 'Testing2',
  dueTime: DateTime.now(),
);

void main() {
  late MyDatabase database;

  setUp(() {
    database = MyDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('todo can be created with addTodo()', () async {
    final id1 = await database.addTodo(_todo1.toCompanion(true));
    final id2 = await database.addTodo(_todo2.toCompanion(true));
    expect(id1, 0);
    expect(id2, 1);
  });

  test('getTodosWithStatus() emits todo lists when creating new todo items',
      () async {
    await expectLater(
      database.getTodosWithStatus(),
      emitsInOrder([[]]),
    );

    await database.addTodo(_todo1.toCompanion(true));
    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo1.title]
      ]),
    );

    await database.addTodo(_todo2.toCompanion(true));
    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo1.title, _todo2.title]
      ]),
    );
  });

  test('table can be cleared with clear()', () async {
    await expectLater(
      database.getTodosWithStatus(),
      emitsInOrder([[]]),
    );

    await database.addTodo(_todo1.toCompanion(true));
    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo1.title]
      ]),
    );

    await database.addTodo(_todo2.toCompanion(true));
    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo1.title, _todo2.title]
      ]),
    );

    expect(await database.clear(), 2);

    await expectLater(
      database.getTodosWithStatus(),
      emitsInOrder([[]]),
    );
  });
}
