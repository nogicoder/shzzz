import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class TodoCount extends Equatable {
  int count;
  final DateTime? dateTime;

  TodoCount({this.count = 0, this.dateTime});

  @override
  List<Object?> get props => [count, dateTime];
}
