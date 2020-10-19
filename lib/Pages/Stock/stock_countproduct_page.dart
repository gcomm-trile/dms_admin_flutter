import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/inventory.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class StockCountProductPage extends StatefulWidget {
  StockCountProductPage({Key key}) : super(key: key);

  @override
  _StockCountProductPageState createState() => _StockCountProductPageState();
}

class _StockCountProductPageState extends State<StockCountProductPage> {
  Widget _buildListView(List<Inventory> data) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(color: Colors.black, thickness: 0.2);
        },
        itemBuilder: (context, index) {
          return ListTile(title: _buildRowListViewSection(data[index]));
        },
        itemCount: data.length);
  }

  Future<List<Inventory>> inventory;
  @override
  void initState() {
    super.initState();
    inventory = API_HELPER.listInventoryProduct();
  }

  Widget get _buildHeaderSection {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(children: <Widget>[
        SizedBox(
          child: Flexible(
            child: Text(
              "Kho",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
          width: 100,
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
            child: Text("Tên",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0))),
        SizedBox(
          child: Text(
            "Tồn",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          width: 70,
        ),
      ]),
    );
  }

  Widget _buildRowListViewSection(Inventory item) {
    return Row(children: <Widget>[
      SizedBox(
        child: Flexible(
          child: Text(
            item.stockName,
            textAlign: TextAlign.center,
          ),
        ),
        width: 100,
      ),
      SizedBox(
        width: 30,
      ),
      Expanded(
        child: Text(
          item.productName,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: Text(
          item.currentQty.toString(),
          textAlign: TextAlign.right,
        ),
        width: 50,
      ),
    ]);
  }

  Widget get _buildRefreshButtonSection {
    return Positioned(
        right: 20,
        bottom: 20,
        height: 50,
        child: FloatingActionButton(
          child: Icon(Icons.update),
          onPressed: () {
            setState(() {
              log("refresh inventory count product data");
              inventory = API_HELPER.listInventoryProduct();
              Get.snackbar("Thông báo", 'Đã cập nhật',
                  duration: Duration(seconds: 1),
                  snackPosition: SnackPosition.BOTTOM);
            });
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tồn kho')),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Inventory>>(
        future: inventory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                snapshot.data.length == 0
                    ? Center(
                        child: Text("No data"),
                      )
                    : Column(
                        children: [
                          _buildHeaderSection,
                          Divider(color: Colors.black, thickness: 3.0),
                          Expanded(child: _buildListView(snapshot.data))
                        ],
                      ),
                _buildRefreshButtonSection
              ],
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
