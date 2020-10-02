import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QtyTextField extends StatefulWidget {
  int value;
  final int maxValue;
  final int minValue;
  final Function(int value) onChangedValue;
  QtyTextField(
      {Key key, this.value, this.maxValue, this.minValue, this.onChangedValue})
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
            width: 40,
            child: RaisedButton(
              color: Colors.transparent,
              onPressed: () {
                _decreaseValue();
              },
              child: Icon(
                Icons.remove,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                widget.onChangedValue(int.parse(value));
              },
              controller: textEditingController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: false),
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            width: 40,
            child: RaisedButton(
              color: Colors.transparent,
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
        widget.onChangedValue(int.parse(textEditingController.text));
      });
    }
  }

  void _decreaseValue() {
    if (int.parse(textEditingController.text) > widget.minValue) {
      setState(() {
        textEditingController.text =
            (int.parse(textEditingController.text) - 1).toString();
        widget.onChangedValue(int.parse(textEditingController.text));
      });
    }
  }
}
