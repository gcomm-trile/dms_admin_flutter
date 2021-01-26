import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListViewRow extends StatelessWidget {
  @required
  final String content;
  @required
  final int countVisit;
  @required
  final int countStoreOrder;
  @required
  final int countOrder;
  @required
  final int sumOrderPrice;
  final formatNumber = new NumberFormat('#,###,###,###', 'en_US');
  final textStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  ListViewRow(
      {Key key,
      this.content,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Text(
              this.content,
              style: textStyle,
            ),
          ),
        ),
        Container(
            width: 70.0,
            child: Text(
              formatNumber.format(countVisit == null ? 0 : countVisit),
              textAlign: TextAlign.center,
              style: textStyle,
            )),
        Container(
            width: 70.0,
            child: Text(
              formatNumber
                  .format(countStoreOrder == null ? 0 : countStoreOrder),
              textAlign: TextAlign.center,
              style: textStyle,
            )),
        Container(
            width: 70.0,
            child: Text(
              formatNumber.format(countOrder == null ? 0 : countOrder),
              textAlign: TextAlign.center,
              style: textStyle,
            )),
        Container(
            width: 120.0,
            child: Text(
              formatNumber.format(sumOrderPrice == null ? 0 : sumOrderPrice),
              textAlign: TextAlign.center,
              style: textStyle,
            )),
      ],
    );
  }
}
