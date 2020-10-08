import 'package:flutter/material.dart';

class ErrorControl extends StatelessWidget {
  final String error;
  const ErrorControl({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 10.0,
        ),
        Text(error)
      ],
    ));
  }
}
