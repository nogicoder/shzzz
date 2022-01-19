import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/shared/index.dart';

extension Equality on Todo {
  bool equals(Todo other) =>
      other.id == this.id &&
      other.title == this.title &&
      checkEqualsDate(other.dueTime, this.dueTime);
}
