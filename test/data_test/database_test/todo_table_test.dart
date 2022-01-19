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

  test('Todo can be created with addTodo()', () async {
    final id1 = await database.addTodo(_todo1);
    final id2 = await database.addTodo(_todo2);
    expect(id1, 0);
    expect(id2, 1);
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

  test('Todo can be deleted with deleteTodo()', () async {
    await database.addTodo(_todo1);
    await database.addTodo(_todo2);

    final numberOfRow = await database.deleteTodo(_todo2);
    expect(numberOfRow, 1);

    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo1.title]
      ]),
    );
  });

  test('Todo can be updated with updateTodo()', () async {
    await database.addTodo(_todo1);

    final _newTodo = _todo1.copyWith(title: generateString(10));
    final numberOfRow = await database.updateTodo(_newTodo);

    expect(numberOfRow, 1);

    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [generateString(10)]
      ]),
    );
  });

  test('Completion status can be updated with updateCompletion()', () async {
    await database.addTodo(_todo1);
    var numberOfRow = await database.updateCompletion(_todo1);
    expect(numberOfRow, 1);

    await expectLater(
      database
          .getTodosWithStatus(isCompleted: true)
          .map((data) => data.map((item) => item.isCompleted).toList()),
      emitsInOrder([
        [true]
      ]),
    );

    final _newTodo = _todo1.copyWith(isCompleted: true);
    numberOfRow = await database.updateCompletion(_newTodo);
    expect(numberOfRow, 1);

    await expectLater(
      database
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.isCompleted).toList()),
      emitsInOrder([
        [false]
      ]),
    );
  });

  test(
      'getCompletedCountByCompletionTime() emits all counts of completed todo items group by their completion time',
      () async {
    await database.addTodo(_todo1);
    await database.addTodo(_todo2);
    await database.updateCompletion(_todo1);
    await database.updateCompletion(_todo2);

    await expectLater(
      database
          .getCompletedCountByCompletionTime()
          .map((data) => data.map((item) => item.count).toList()),
      emitsInOrder([
        [2]
      ]),
    );
  });

  test(
      'getCountByDueTime() emits all counts of all todo items group by their due time',
      () async {
    await database.addTodo(_todo1);
    await database.addTodo(_todo2);

    await expectLater(
      database
          .getCountByDueTime()
          .map((data) => data.map((item) => item.count).toList()),
      emitsInOrder([
        [2]
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
}
