import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/inventory.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

import '../../constants.dart';

class StockCountProductPage extends StatefulWidget {
  final String stock_id;
  StockCountProductPage({Key key, this.stock_id}) : super(key: key);

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
    inventory = API_HELPER.getInventory(widget.stock_id);
  }

  Widget get _buildHeaderSection {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(children: <Widget>[
        SizedBox(
          child: Text(
            "Mã",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          width: kWidthProductNo,
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
        child: Text(
          item.productNo,
          textAlign: TextAlign.center,
        ),
        width: kWidthProductNo,
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
              inventory = API_HELPER.getInventory(widget.stock_id);
              UI.showSuccess(context, "Đã load lại danh sách thành công");
            });
          },
        ));
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
    );
  }
}
