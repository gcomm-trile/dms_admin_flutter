import 'package:flutter/material.dart';

class HeaderListViewProduct extends StatelessWidget {
  final double sizedQty;
  const HeaderListViewProduct({Key key, this.sizedQty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle styleHeader = TextStyle(
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
                style: styleHeader,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: sizedQty,
              child: Container(
                  child: Text(
                "SL",
                style: styleHeader,
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
