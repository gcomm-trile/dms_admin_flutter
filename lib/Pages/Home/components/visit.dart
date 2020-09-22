import 'package:flutter/material.dart';
import 'drawer.dart';

class Visit extends StatelessWidget {
  const Visit({Key key}) : super(key: key);
  static const String routeName = "/visit";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(routeName),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text(routeName)));
  }
}
