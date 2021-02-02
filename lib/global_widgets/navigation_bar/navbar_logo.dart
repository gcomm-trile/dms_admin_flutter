import 'package:flutter/material.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 150,
      child: Icon(Icons
          .move_to_inbox), // Image.asset('assets//images/ic_launcher.png'),
    );
  }
}
