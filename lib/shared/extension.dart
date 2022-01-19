import 'package:shzzz/data/database/todo_table.dart';

extension Equality on Todo {
  bool equals(Todo other) =>
      other.id == this.id &&
      other.title == this.title &&
      other.dueTime == this.dueTime;
}
