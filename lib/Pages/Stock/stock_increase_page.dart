import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/phieu_nhap.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_approve_page.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_import_page.dart';
import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/components/row_info_section.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class StockIncreasePage extends StatefulWidget {
  StockIncreasePage({Key key}) : super(key: key);

  @override
  _StockIncreasePageState createState() => _StockIncreasePageState();
}

class _StockIncreasePageState extends State<StockIncreasePage> {
  Future<List<PhieuNhap>> phieuNhap;
  @override
  void initState() {
    super.initState();
    phieuNhap = API_HELPER.listPhieuNhap();
  }

  Widget _buildListViewSection(List<PhieuNhap> data) {
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
                            border: Border.all(
                                color: kPrimaryLightColor, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Text(
                            item.seqNo == null ? 'N/A' : item.seqNo,
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                          ),
                        )),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            RowInfoSection(
                                iconData: Icons.call_received,
                                text: item.importStockName),
                            RowInfoSection(
                                iconData: Icons.call_made,
                                text: item.exportStockName),
                            RowInfoSection(
                                iconData: Icons.timer, text: item.createdOn),
                            RowInfoSection(
                                iconData: Icons.person,
                                text: item.createdByFullname)
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
          phieuNhap = API_HELPER.listPhieuNhap();
        });
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockIncreaseImportPage(phieuNhapId: id),
          )).then((value) {
        setState(() {
          phieuNhap = API_HELPER.listPhieuNhap();
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
    return Scaffold(
      appBar: AppBar(title: Text('Nhập kho')),
      drawer: AppDrawer(),
      body: FutureBuilder<List<PhieuNhap>>(
        future: phieuNhap,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.all(5.0),
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
            return Center(child: Text("${snapshot.error}"));
          }
          return LoadingControl();
        },
      ),
    );
  }
}
