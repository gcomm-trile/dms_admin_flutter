import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_nhap.dart';
import 'package:dms_admin/Pages/Stock/stock_request_import_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class StockIncreasePage extends StatefulWidget {
  final String stock_id;
  StockIncreasePage({Key key, this.stock_id}) : super(key: key);

  @override
  _StockIncreasePageState createState() => _StockIncreasePageState();
}

class _StockIncreasePageState extends State<StockIncreasePage> {
  Future<List<PhieuNhap>> phieuNhap;
  @override
  void initState() {
    super.initState();
    phieuNhap = API_HELPER.fetchPhieuNhap(widget.stock_id);
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<PhieuNhap>>(
      future: phieuNhap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              snapshot.data.length == 0
                  ? Center(
                      child: Text("No data"),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(color: Colors.black, thickness: 1.0);
                      },
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ListTile(
                            title: Row(children: <Widget>[
                              Text(
                                "Mã",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          );
                        } else
                          return ListTile(
                            title: Row(children: <Widget>[
                              Text(snapshot.data[index - 1].seq)
                            ]),
                          );
                      },
                      itemCount: snapshot.data.length + 1),
              Positioned(
                  right: 20,
                  bottom: 20,
                  height: 50,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      log("Thêm đơn nhập mới");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StockRequestImportPage(
                              phieuNhapId: Guid.newGuid.toString(),
                            ),
                          ));
                    },
                  ))
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
