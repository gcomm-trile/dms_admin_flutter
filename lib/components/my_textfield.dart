import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String text;
  final String title;
  final Function(String textValue) onChangedText;

  MyTextField({this.text, this.title, this.onChangedText});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  TextEditingController textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = new TextEditingController()..text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textEditingController,
        onChanged: (value) {
          setState(() {
            widget.onChangedText(value);
          });
        },
        decoration: new InputDecoration(labelText: widget.title));
  }
}
