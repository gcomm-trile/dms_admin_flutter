import 'package:flutter/material.dart';

class LoadingControl extends StatelessWidget {
  const LoadingControl({Key key}) : super(key: key);

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
        Text("Đang tải")
      ],
    ));
  }
}
