import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/phieu_xuat.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_export_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class StockDecreasePage extends StatefulWidget {
  final String stockId;
  StockDecreasePage({Key key, this.stockId}) : super(key: key);

  @override
  _StockDecreasePageState createState() => _StockDecreasePageState();
}

class _StockDecreasePageState extends State<StockDecreasePage> {
  Future<List<PhieuXuat>> phieuXuat;
  @override
  void initState() {
    super.initState();
    phieuXuat = API_HELPER.getPhieuXuat(widget.stockId);
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<PhieuXuat>>(
      future: phieuXuat,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              snapshot.data.length == 0
                  ? Center(
                      child: Text("No data"),
                    )
                  : Column(children: [
                      _buildHeaderListViewSection,
                      Divider(color: Colors.black, thickness: 3.0),
                      Expanded(child: _buildListViewSection(snapshot.data))
                    ]),
              _buildAddButtonSection
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSizedBox(double width) {
    return SizedBox.fromSize(
      size: Size.fromWidth(width),
    );
  }

  Widget get _buildHeaderListViewSection {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 10),
        width: 120,
        child: Text(
          "Mã",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 10),
        width: 120,
        child: Text(
          "Tình trạng",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          width: 120,
          child: Text(
            "Người duyệt",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 10),
        width: 120,
        child: Text(
          "Ngày duyệt",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }

  Widget _buildListViewSection(List<PhieuXuat> data) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(color: Colors.black, thickness: 1.0);
        },
        itemBuilder: (context, index) {
          return _buildRowListViewSection(data[index]);
        },
        itemCount: data.length);
  }

  Widget _buildRowListViewSection(PhieuXuat item) {
    return InkWell(
      onDoubleTap: () {
        log("mở lại  đơn cũ");
        goToDetailPage(item.id);
      },
      child: Row(children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          width: 120,
          child: Text(
            item.seq,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          width: 120,
          child: Text(
            item.status,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10),
            width: 120,
            child: Text(
              item.approvedBy,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          width: 120,
          child: Text(
            item.approvedOn,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }

  void goToDetailPage(String phieuNhapId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockDecreaseExportPage(
              phieuNhapId: phieuNhapId, stockId: widget.stockId),
        )).then((value) {
      setState(() {
        phieuXuat = API_HELPER.getPhieuXuat(widget.stockId);
      });
    });
  }

  Widget get _buildAddButtonSection {
    return Positioned(
        right: 20,
        bottom: 20,
        height: 50,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            log("Thêm đơn nhập mới");
            goToDetailPage(Guid.newGuid.toString());
          },
        ));
  }
}
