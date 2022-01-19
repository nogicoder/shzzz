import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/shared/index.dart';

final _todo1 = Todo(
  id: 0,
  title: generateString(6),
  dueTime: DateTime.now(),
);

final _todo2 = Todo(
  id: 1,
  title: generateString(7),
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
    final id1 = await database.addTodo(_todo1);
    final id2 = await database.addTodo(_todo2);
    expect(id1, 0);
    expect(id2, 1);
  });

  test('todo can be updated with updateTodo()', () async {
    final id = await database.addTodo(_todo1);

    expect(id, 0);

    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [generateString(6)]
      ]),
    );

    final _newTodo = _todo1.copyWith(title: generateString(10));
    final updateId = await database.updateTodo(_newTodo);

    expect(updateId, 1);

    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [generateString(10)]
      ]),
    );
  });

  test('getTodosWithStatus() emits todo lists when creating new todo items',
      () async {
    await expectLater(
      database.getTodosWithStatus(),
      emitsInOrder([[]]),
    );

    await database.addTodo(_todo1);
    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo1.title]
      ]),
    );

    await database.addTodo(_todo2);
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
    await database.addTodo(_todo1);
    await database.addTodo(_todo2);
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

  test('checkEqualsDate() return correct result', () async {
    expect(
      await database.checkEqualsDate(DateTime.now(), DateTime.now()),
      true,
    );
    expect(
      await database.checkEqualsDate(
          DateTime.now(), DateTime.now().add(Duration(days: 1))),
      false,
    );
  });
}
