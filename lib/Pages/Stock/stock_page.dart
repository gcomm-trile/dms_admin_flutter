import 'dart:developer';
import 'package:dms_admin/Data/api_helper.dart';

import 'package:dms_admin/Models/stock.dart';
import 'package:dms_admin/Pages/Stock/stock_detail_page.dart';
import 'package:dms_admin/Pages/Stock/stock_info_page.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class StockPage extends StatefulWidget {
  static const String routeName = "/stock";
  StockPage({Key key}) : super(key: key);

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  Future<List<Stock>> stocks;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    stocks = API_HELPER.listStocks();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Danh mục kho"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder<List<Stock>>(
          future: stocks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  ListView.separated(
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
                      itemCount: snapshot.data.length),
                  Positioned(
                      right: 30,
                      bottom: 30,
                      width: 50,
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          log("add new stock");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(5.0),
                                  elevation: 4.0,
                                  content: Container(
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        StockInfoPage(new Stock(
                                            no: "",
                                            name: "",
                                            is_active: true,
                                            id: Guid.newGuid.toString())),
                                      ],
                                    ),
                                  ),
                                );
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
        ));
  }

  _buildRow(BuildContext context, int index, List<Stock> data) {
    return InkWell(
        onTap: () {
          log("Item tapped " + index.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StockDetailPage(
                      data: data[index],
                    )),
          ).then((value) => _getSource());
        },
        child: Row(children: [Text(data[index].name)]));
  }

  _getSource() async {
    setState(() {
      log("refresh stock list");
      stocks = API_HELPER.listStocks();
    });
  }
}
