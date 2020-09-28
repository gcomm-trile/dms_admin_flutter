import 'package:dms_admin/Models/phieu_nhap.dart';
import 'package:flutter/material.dart';

class StockDecreasePage extends StatefulWidget {
  StockDecreasePage({Key key, String stock_id}) : super(key: key);

  @override
  _StockDecreasePageState createState() => _StockDecreasePageState();
}

class _StockDecreasePageState extends State<StockDecreasePage> {
  Future<List<PhieuNhap>> phieuNhaps;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("StockDecreasePage"),
      ),
    );
  }
}
