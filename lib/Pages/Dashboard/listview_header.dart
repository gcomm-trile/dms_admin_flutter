import 'package:flutter/material.dart';

class ListViewHeader extends StatelessWidget {
  const ListViewHeader({Key key}) : super(key: key);
  static const headerTextStyle = TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        Container(
            width: 70.0,
            child: Text(
              'Thăm viếng',
              textAlign: TextAlign.center,
              style: headerTextStyle,
            )),
        Container(
            width: 70.0,
            child: Text(
              'Có đơn hàng',
              textAlign: TextAlign.center,
              style: headerTextStyle,
            )),
        Container(
            width: 70.0,
            child: Text(
              'Số đơn hàng',
              textAlign: TextAlign.center,
              style: headerTextStyle,
            )),
        Container(
            width: 70.0,
            child: Text('Tổng tiền',
                textAlign: TextAlign.center, style: headerTextStyle)),
      ],
    );
  }
}
