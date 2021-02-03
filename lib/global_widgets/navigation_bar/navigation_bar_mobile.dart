import 'package:flutter/material.dart';

import 'navbar_logo.dart';

class NavigationBarMobile extends StatelessWidget {
  final Function menuOnPressed;
  const NavigationBarMobile({Key key, this.menuOnPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              if (menuOnPressed != null) {
                print('menu click');
                menuOnPressed();
              }
            },
          ),
          NavBarLogo()
        ],
      ),
    );
  }
}
