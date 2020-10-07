import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/order.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Pages/Order/order_detail_page.dart';
import 'package:dms_admin/Pages/Order/order_detail_page.dart';
import 'package:dms_admin/Pages/Product/product_detail_page.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = "/order";
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<List<Order>> data;
  List<Order> original_data = new List<Order>();
  List<Order> search_data = new List<Order>();

  final formatter = new NumberFormat("#,###");

  TextEditingController editingController = TextEditingController();

  _getRequests() async {
    log("refresh page");
    setState(() {
      data = API_HELPER.listOrder();
    });
  }

  @override
  void initState() {
    super.initState();
    data = API_HELPER.listOrder();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Đơn hàng"),
          ),
          drawer: AppDrawer(),
          body: FutureBuilder<List<Order>>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                original_data = snapshot.data;
                if (editingController.text.isEmpty) {
                  search_data = original_data;
                } else {
                  search_data = original_data
                      .where((element) => element.seq
                          .toLowerCase()
                          .contains(editingController.text.toLowerCase()))
                      .toList();
                }
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Column(children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Expanded(child: _buildRowSearch(search_data))
                  ]),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              return LoadingControl();
            },
          )),
    );
  }

  Widget _buildInfoItem(IconData iconData, String textInfo) {
    return Container(
      child: Row(
        children: [
          Icon(iconData),
          Flexible(
            child: Text(textInfo),
          ),
        ],
      ),
    );
  }

  Widget _buildRowSearch(List<Order> data) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 0.5,
            color: Colors.black,
          );
        },
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildRowListView(data[index]);
        });
  }

  void onSearchTextChanged(String value) async {
    if (value.isNotEmpty) {
      setState(() {
        search_data = original_data
            .where((element) =>
                element.seq.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        search_data = original_data.where((element) => 1 == 1).toList();
      });
    }
    return;

    // _userDetails.forEach((userDetail) {
    //   if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //     _searchResult.add(userDetail);
    // });
  }

  Widget _buildRowListView(Order item) {
    return InkWell(
        onTap: () {
          log("item search selected");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailPage(
                      order_id: item.id,
                    )),
          ).then((value) => _getRequests());
        },
        child: Stack(children: [
          Container(
            margin: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border:
                          Border.all(color: kPrimaryLightColor, width: 2.0)),
                  child: Center(
                      child: Text(
                    item.seq,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  )),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        _buildInfoItem(Icons.store, item.storeName),
                        _buildInfoItem(
                            Icons.gps_fixed, item.storeAddress.toUpperCase()),
                        _buildInfoItem(Icons.person, item.createdByName),
                        _buildInfoItem(Icons.timer, item.createdOn),
                      ],
                    ),
                  ),
                )
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
                    color: item.isExportedStock == true
                        ? Colors.green
                        : Colors.red,
                  ),
                  child: Text(
                    item.isExportedStock == true ? 'Đã duyệt' : 'Chưa duyệt',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
        ]));
  }
}
