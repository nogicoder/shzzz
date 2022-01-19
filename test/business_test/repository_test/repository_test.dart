import 'package:flutter_test/flutter_test.dart';
import 'package:shzzz/business/repository/repository.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/data/index.dart';
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

final _todoCount1 = TodoCount(
  count: 1,
  dateTime: DateTime.now(),
);

final _todoCount2 = TodoCount(
  count: 2,
  dateTime: DateTime.now(),
);

class MockDatabase extends Fake implements MyDatabase {
  @override
  Future<int> addTodo(Todo entry) => Future.value(0);

  @override
  Future<int> deleteTodo(Todo entry) => Future.value(1);

  @override
  Future<int> updateTodo(Todo todo) => Future.value(1);

  @override
  Future<int> updateCompletion(Todo todo) => Future.value(1);

  @override
  Stream<List<Todo>> getTodosWithStatus({bool isCompleted = false}) =>
      isCompleted ? Stream.value([_todo1]) : Stream.value([_todo2]);

  @override
  Stream<List<TodoCount>> getCompletedCountByCompletionTime() =>
      Stream.value([_todoCount1, _todoCount2]);

  @override
  Stream<List<TodoCount>> getCountByDueTime() =>
      Stream.value([_todoCount1, _todoCount2]);

  @override
  Future<int> clear() => Future.value(5);
}

void main() {
  final repository = Repository(MockDatabase());

  test('addTodo() should return row number of successfully added item',
      () async {
    expect(await repository.addTodo(_todo1), 0);
  });

  test('getTodosWithStatus() should get all todos based on completion status',
      () async {
    await expectLater(
      repository
          .getTodosWithStatus()
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo2.title]
      ]),
    );

    await expectLater(
      repository
          .getTodosWithStatus(isCompleted: true)
          .map((data) => data.map((item) => item.title).toList()),
      emitsInOrder([
        [_todo1.title]
      ]),
    );
  });

  test('deleteTodo() should return number of rows affected', () async {
    expect(await repository.deleteTodo(_todo1), 1);
  });

  test('updateTodo() should return number of rows affected', () async {
    expect(await repository.updateTodo(_todo2), 1);
  });

  test('updateCompletion() should return number of rows affected', () async {
    expect(await repository.updateCompletion(_todo1), 1);
  });

  test(
      'getCompletedCountByCompletionTime() should return counts of completed todos by their completion time',
      () async {
    await expectLater(
      repository
          .getCompletedCountByCompletionTime()
          .map((data) => data.map((item) => item.count).toList()),
      emitsInOrder([
        [1, 2]
      ]),
    );
  });

  test(
      'getCountByDueTime() should return counts of all todos by their due time',
      () async {
    await expectLater(
      repository
          .getCountByDueTime()
          .map((data) => data.map((item) => item.count).toList()),
      emitsInOrder([
        [1, 2]
      ]),
    );
  });

  test('clearDatabase() should return number of rows affected', () async {
    expect(await repository.clearDatabase(), 5);
  });
}
