import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/inventory.dart';
import 'package:flutter/material.dart';

class StockCountProductPage extends StatefulWidget {
  final String stock_id;
  StockCountProductPage({Key key, this.stock_id}) : super(key: key);

  @override
  _StockCountProductPageState createState() => _StockCountProductPageState();
}

class _StockCountProductPageState extends State<StockCountProductPage> {
  Widget _buildRowListView() {
    return Text("Hello");
  }

  Future<List<Inventory>> inventory;
  @override
  void initState() {
    super.initState();
    inventory = API_HELPER.getInventory(widget.stock_id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Inventory>>(
      future: inventory,
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
                                child: Text(snapshot.data[index - 1].productNo),
                                width: 80,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child:
                                    Text(snapshot.data[index - 1].productName),
                              ),
                              SizedBox(
                                child: Text(snapshot.data[index - 1].currentQty
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
                    child: Icon(Icons.update),
                    onPressed: () {
                      setState(() {
                        log("refresh inventory count product data");
                        inventory = API_HELPER.getInventory(widget.stock_id);
                        UI.showSuccess(
                            context, "Đã load lại danh sách thành công");
                      });
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
