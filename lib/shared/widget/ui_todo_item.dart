import 'package:flutter/material.dart';
import 'package:shzzz/shared/index.dart';

class UITodoItem extends StatelessWidget {
  const UITodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: Constants.kBorderRadiusStandard,
      ),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {},
            shape: CircleBorder(
              side: BorderSide(color: Colors.grey),
            ),
          ),
          Text(
            'Content',
            style: UITextStyle.bodyStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
