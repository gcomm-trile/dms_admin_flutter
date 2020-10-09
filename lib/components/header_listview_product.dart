import 'package:flutter/material.dart';

class HeaderListViewProduct extends StatelessWidget {
  final double sized_qty;
  const HeaderListViewProduct({Key key, this.sized_qty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _style_header = TextStyle(
        color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);

    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Container(
              child: Text(
                "Tên SP",
                style: _style_header,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: sized_qty,
              child: Container(
                  child: Text(
                "SL",
                style: _style_header,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }
}
