import 'package:flutter/material.dart';

class RowInfoSection extends StatelessWidget {
  final IconData iconData;
  final String text;
  const RowInfoSection({Key key, this.iconData, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(iconData),
          Flexible(
            child: Text(text==null ? 'N/A':text),
          ),
        ],
      ),
    );
  }
}
