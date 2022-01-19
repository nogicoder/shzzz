import 'package:equatable/equatable.dart';

class TodoCount extends Equatable {
  int count;
  final DateTime? dateTime;

  TodoCount({this.count = 0, this.dateTime});

  @override
  List<Object?> get props => [count, dateTime];
}
