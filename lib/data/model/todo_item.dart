class TodoItem {
  final int? id;
  final String? title;
  final String? content;
  final String? category;
  final DateTime? createdTime;
  final DateTime? dueTime;

  TodoItem(
      {this.id,
      this.title,
      this.content,
      this.category,
      this.createdTime,
      this.dueTime});
}
