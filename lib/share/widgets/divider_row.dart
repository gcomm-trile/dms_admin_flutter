import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.7,
      color: kPrimaryColor,
    );
  }
}
