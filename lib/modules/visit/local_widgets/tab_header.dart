import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {
  final String title;

  const TabHeader({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        // margin: EdgeInsets.only(top: 5),
        width: 100,
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}
