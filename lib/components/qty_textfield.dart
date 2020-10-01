import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QtyTextField extends StatefulWidget {
  int value;
  final int maxValue;
  final int minValue;
  QtyTextField({Key key, this.value, this.maxValue, this.minValue})
      : super(key: key);

  @override
  _QtyTextFieldState createState() => _QtyTextFieldState();
}

class _QtyTextFieldState extends State<QtyTextField> {
  TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = new TextEditingController()
      ..text = widget.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Row(
        children: [
          Container(
            width: 50,
            child: RaisedButton(
              onPressed: () {
                _decreaseValue();
              },
              child: Icon(
                Icons.remove,
                color: Colors.deepOrange,
              ),
            ),
          ),
          Expanded(
              child: TextField(
            maxLength: widget.maxValue.toString().length,
            textAlign: TextAlign.center,
            onChanged: (value) {},
            controller: textEditingController,
            decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
              ),
            ),
          )),
          Container(
            width: 50,
            child: RaisedButton(
              onPressed: () {
                _increaseValue();
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _increaseValue() {
    if (int.parse(textEditingController.text) < widget.maxValue) {
      setState(() {
        textEditingController.text =
            (int.parse(textEditingController.text) + 1).toString();
      });
    }
  }

  void _decreaseValue() {
    if (int.parse(textEditingController.text) > widget.minValue) {
      setState(() {
        textEditingController.text =
            (int.parse(textEditingController.text) - 1).toString();
      });
    }
  }
}
