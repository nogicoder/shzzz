import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shzzz/data/database/todo_table.dart';
import 'package:shzzz/shared/index.dart';
import 'package:shzzz/shared/widget/ui_todo_item/ui_todo_item_controller.dart';

/// Display the UI for a single todo item with following elements:
/// - A [Checkbox] to reflects completion status of the todo item
/// - A [String] to display the item's title
/// The widget is slidable to the left, revealing the delete button to remove
/// the todo item from Local Database using [MyDatabase.deleteEntry]
class UITodoItem extends StatelessWidget {
  final Todo todo;
  UITodoItem({Key? key, required this.todo}) : super(key: key);

  final UITodoItemController controller = UITodoItemController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goCreateTodoDialog(todo: todo),
      child: Slidable(
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) async {
              await controller.deleteTodo(todo);
              Get.snackbar(APP_TITLE, tr().success_deleting_task);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: CupertinoIcons.delete,
          ),
        ]),
        child: Container(
          padding: EdgeInsets.all(Constants.kSmallPadding),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: Constants.kBorderRadiusStandard,
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => controller.updateStatus(todo),
                  shape: CircleBorder(),
                  fillColor: MaterialStateProperty.all(
                    (todo.isCompleted ?? false)
                        ? Get.theme.colorScheme.surface
                        : Get.theme.colorScheme.secondary,
                  ),
                ),
              ),
              Text(
                todo.title,
                style: UITextStyle.bodyStyle(
                  color: null,
                ).copyWith(
                    decoration: (todo.isCompleted ?? false)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
