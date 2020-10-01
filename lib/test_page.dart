import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 150,
        child: Row(
          children: [
            Container(
              width: 50,
              child: RaisedButton(
                onPressed: () {},
                child: Icon(
                  Icons.remove,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Expanded(
                child: TextField(
              decoration: InputDecoration(border: InputBorder.none),
            )),
            Container(
              width: 50,
              child: RaisedButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
