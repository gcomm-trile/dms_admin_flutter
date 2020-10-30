import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final int maxLine;
  const RoundedInputField(
      {Key key, this.hintText, this.icon, this.onChanged, this.maxLine = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        maxLines: maxLine,
        decoration: this.icon == null
            ? InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              )
            : InputDecoration(
                icon: Icon(
                  icon,
                  color: kPrimaryColor,
                ),
                hintText: hintText,
                border: InputBorder.none,
              ),
      ),
    );
  }
}
