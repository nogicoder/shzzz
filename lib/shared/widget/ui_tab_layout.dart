import 'package:flutter/material.dart';
import 'package:shzzz/business/services/index.dart';
import 'package:shzzz/shared/index.dart';

class UITabLayout extends StatelessWidget {
  final Widget child;
  const UITabLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 150,
          child: child,
        ),
        Positioned(
          top: 50,
          left: Constants.kOuterPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.menu,
                color: Colors.teal,
                size: 30,
              ),
              SizedBox(height: Constants.kOuterPadding),
              Text(
                "What's up, ${userConfigService.userInfo?.name ?? ''}!",
                style: UITextStyle.headline4(FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
