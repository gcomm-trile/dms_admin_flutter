import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'navigation_bar_mobile.dart';
import 'navigation_bar_tablet_desktop.dart';

class NavigationBar extends StatelessWidget {
  final Function menuOnPressed;
  const NavigationBar({Key key, this.menuOnPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(
        menuOnPressed: menuOnPressed(),
      ),
      tablet: NavigationBarTabletDesktop(),
    );
  }
}
