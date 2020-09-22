import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final bool isActive;
  final String title;
  MyCheckbox(this.isActive, this.title, {Key key}) : super(key: key);
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool checkedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkedValue = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }
}
