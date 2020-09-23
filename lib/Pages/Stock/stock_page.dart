import 'dart:developer';
import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Models/stock.dart';
import 'package:dms_admin/Pages/Stock/stock_page_detail.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  static const String routeName = "/stock";
  StockPage({Key key}) : super(key: key);

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  Future<List<Stock>> stocks;
  @override
  void initState() {
    super.initState();
    stocks = API_HELPER.fetchStock();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text("Danh mục kho"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder<List<Stock>>(
          future: stocks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      _buildRow(context, index, snapshot.data),
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: kPrimaryColor,
                      thickness: 2.0,
                      indent: 5,
                      endIndent: 5,
                    );
                  },
                  itemCount: snapshot.data.length);
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  _buildRow(BuildContext context, int index, List<Stock> data) {
    return InkWell(
        onTap: () {
          log("Item tapped " + index.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StockDetailPage(data[index])),
          ).then((value) => _getSource());
        },
        child: Row(children: [Text(data[index].name)]));
  }

  _getSource() async {
    setState(() {
      stocks = API_HELPER.fetchStock();
    });
  }
}
