import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconText({Key key, @required this.icon, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: kIconSize),
        SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            text,
            style: kStyleListViewItem,
          ),
        )
      ],
    );
  }
}
