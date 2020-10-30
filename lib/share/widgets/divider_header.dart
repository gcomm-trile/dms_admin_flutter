import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class DividerHeader extends StatelessWidget {
  const DividerHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 3.0,
      color: kPrimaryColor,
    );
  }
}
