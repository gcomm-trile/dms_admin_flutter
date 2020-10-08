import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/phieu_xuat.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_export_for_order_page.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_export_page.dart';
import 'package:dms_admin/components/error.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/components/row_info_section.dart';
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
                        Expanded(child: _buildListViewSection(snapshot.data))
                      ]),
                _buildAddButtonSection
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorControl(
            error: snapshot.error,
          );
        }
        return LoadingControl();
      },
    );
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
        if (item.type == 2) {
          goToExportOrderDetail(item.id);
        } else {
          goToExportPageDetail(item.id);
        }
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0)),
              height: 100,
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.all(5.0),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: kPrimaryLightColor, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Text(
                          item.seqNo,
                          style: TextStyle(color: Colors.black, fontSize: 25.0),
                        ),
                      )),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          RowInfoSection(
                              iconData: item.type == 1
                                  ? Icons.call_received
                                  : Icons.store,
                              text: item.importStockName),
                          RowInfoSection(
                              iconData: Icons.timer, text: item.createdOn),
                          RowInfoSection(
                              iconData: Icons.person, text: item.createdByName)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 8,
                top: 8,
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: item.status == 1 ? Colors.red : Colors.green,
                    ),
                    child: Text(
                      item.statusName,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
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
            goToExportPageDetail(Guid.newGuid.toString());
          },
        ));
  }

  void goToExportPageDetail(String phieuXuatId) {
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

  void goToExportOrderDetail(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockDecreaseExportForOrderPage(
              order_id: id, stockId: widget.stockId),
        )).then((value) {
      setState(() {
        phieuXuat = API_HELPER.listPhieuXuat(widget.stockId);
      });
    });
  }
}
