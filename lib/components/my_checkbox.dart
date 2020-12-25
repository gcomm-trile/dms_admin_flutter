import 'package:flutter/material.dart';

class MyCheckbox extends StatefulWidget {
  final bool isActive;
  final String title;
  final Function(bool checkedValue) onChangedCheck;

  MyCheckbox({this.onChangedCheck, this.isActive, this.title});
  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool checkedValue;

  @override
  void initState() {
    super.initState();
    setState(() {
      checkedValue = widget.isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.all(0),
      child: CheckboxListTile(
        title: Text(widget.title),
        value: checkedValue,
        onChanged: (newValue) {
          setState(() {
            checkedValue = newValue;
            widget.onChangedCheck(checkedValue);
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }
}
