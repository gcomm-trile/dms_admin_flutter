import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_nhap_detail.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Pages/Product/product_search_page.dart';
import 'package:dms_admin/components/my_textfield.dart';

import 'package:flutter/material.dart';

class StockRequestImportPage extends StatefulWidget {
  final String phieuNhapId;
  StockRequestImportPage({Key key, this.phieuNhapId}) : super(key: key);

  @override
  _StockRequestImportPageState createState() => _StockRequestImportPageState();
}

class _StockRequestImportPageState extends State<StockRequestImportPage> {
  Future<List<PhieuNhapDetail>> phieuNhapDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phieuNhapDetails = API_HELPER.fetchPhieuNhapDetail(widget.phieuNhapId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết phiếu nhập"),
          actions: [
            RaisedButton(
              color: Colors.transparent,
              onPressed: () {
                UI.showSuccess(context, "Đã cập nhật thành công");
                Navigator.pop(context);
              },
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: FutureBuilder<List<PhieuNhapDetail>>(
          future: phieuNhapDetails,
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
                                  SizedBox(
                                    child: Text(
                                      "Mã",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Text("Tên",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    child: Text("Tồn",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    width: 50,
                                  ),
                                ]),
                              );
                            } else
                              return ListTile(
                                title: Row(children: <Widget>[
                                  SizedBox(
                                    child: Text(
                                        snapshot.data[index - 1].productNo),
                                    width: 80,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Text(
                                        snapshot.data[index - 1].productName),
                                  ),
                                  SizedBox(
                                    child: Text(snapshot
                                        .data[index - 1].productPrice
                                        .toString()),
                                    width: 50,
                                  ),
                                ]),
                              );
                          },
                          itemCount: snapshot.data.length),
                  Positioned(
                      right: 20,
                      bottom: 20,
                      height: 50,
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          log("Thêm sản phẩm mới");
                          _showPopupProduct(context);
                        },
                      ))
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  void _showPopupProduct(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: ProductSearchPage(),
          );
        });
  }
}
