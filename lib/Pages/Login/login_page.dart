import 'package:flutter/material.dart';
import 'package:dms_admin/Pages/Login/components/body.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: Scaffold(
      body: SafeArea(child: Body()),
    ));
  }
}
