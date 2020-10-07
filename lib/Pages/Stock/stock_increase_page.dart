import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/phieu_nhap.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_approve_page.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_import_page.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class StockIncreasePage extends StatefulWidget {
  final String stockId;
  StockIncreasePage({Key key, this.stockId}) : super(key: key);

  @override
  _StockIncreasePageState createState() => _StockIncreasePageState();
}

class _StockIncreasePageState extends State<StockIncreasePage> {
  Future<List<PhieuNhap>> phieuNhap;
  @override
  void initState() {
    super.initState();
    phieuNhap = API_HELPER.listPhieuNhap(widget.stockId);
  }

  Widget _buildListViewSection(List<PhieuNhap> data) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(color: Colors.black, thickness: 0.2);
        },
        itemBuilder: (context, index) {
          return _buildRowListViewSection(data[index]);
        },
        itemCount: data.length);
  }

  Widget _buildRowListViewSection(PhieuNhap item) {
    return InkWell(
        onTap: () {
          log("mở lại  đơn nhập cũ ${item.id}");
          goToDetailPage(item.id, item);
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
                            item.seqNo == null ? "N/A" : item.seqNo,
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                          ),
                        )),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.call_made),
                                Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(item.exportStockName == null
                                        ? "N/A"
                                        : item.exportStockName)),
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
                                    item.createdByFullname,
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
        ));
  }

  void goToDetailPage(String id, PhieuNhap item) {
    if (item != null &&
        item.exportStockId != "00000000-0000-0000-0000-000000000000") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockIncreaseApprovePage(
              phieuXuatId: id,
            ),
          )).then((value) {
        setState(() {
          phieuNhap = API_HELPER.listPhieuNhap(widget.stockId);
        });
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockIncreaseImportPage(
                phieuNhapId: id, stockId: widget.stockId),
          )).then((value) {
        setState(() {
          phieuNhap = API_HELPER.listPhieuNhap(widget.stockId);
        });
      });
    }
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
            goToDetailPage(Guid.newGuid.toString(), null);
          },
        ));
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
                  : Column(children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(child: _buildListViewSection(snapshot.data))
                    ]),
              _buildAddButtonSection
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return LoadingControl();
      },
    );
  }
}
