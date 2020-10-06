import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/phieu_xuat.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_export_page.dart';
import 'package:dms_admin/constants.dart';
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
    phieuXuat = API_HELPER.listPhieuXuat(widget.stockId);
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<PhieuXuat>>(
      future: phieuXuat,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.all(10.0),
            child: Stack(
              children: [
                snapshot.data.length == 0
                    ? Center(
                        child: Text("No data"),
                      )
                    : Column(children: [
                        // _buildHeaderListViewSection,

                        Expanded(child: _buildListViewSection(snapshot.data))
                      ]),
                _buildAddButtonSection
              ],
            ),
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
        return Divider(
          thickness: 0.5,
          color: Colors.black,
        );
      },
      itemBuilder: (context, index) {
        return _buildRowListViewSection(data[index]);
      },
      itemCount: data.length,
    );
  }

  Widget _buildRowListViewSection(PhieuXuat item) {
    return InkWell(
      onTap: () {
        log("mở lại  đơn cũ");
        goToDetailPage(item.id);
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              height: 100,
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.all(5.0),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)),
                      child: Center(
                        child: Text(
                          item.seqNo,
                          style: TextStyle(color: Colors.black, fontSize: 25.0),
                        ),
                      )),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.call_received),
                              Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(item.importStockName)),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  item.createdByName,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.timer),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  item.createdOn,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                right: 5.0,
                top: 5.0,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Text(
                      item.statusName,
                      style: TextStyle(color: Colors.red),
                    ))),
          ],
        ),
      ),
    );
  }

  void goToDetailPage(String phieuXuatId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockDecreaseExportPage(
              phieuXuatId: phieuXuatId, stockId: widget.stockId),
        )).then((value) {
      setState(() {
        phieuXuat = API_HELPER.listPhieuXuat(widget.stockId);
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
