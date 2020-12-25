import 'dart:developer';

import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/modules/order/order_controller.dart';
import 'package:dms_admin/modules/order/order_detail_page.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class OrderPage extends GetView<OrderController> {
  OrderPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng"),
      ),
      drawer: AppDrawer(),
      body: GetX<OrderController>(
        initState: (state) {
          Get.find<OrderController>().getAll();
        },
        builder: (_) {
          return _.orderList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        height: 1,
                      ),
                  itemCount: _.orderList.length,
                  itemBuilder: (context, index) {
                    return _buildRowListViewSection(_.orderList[index]);
                  });
        },
      ),
    ));
  }

  

  Widget _buildRowListViewSection(Order item) {
    return InkWell(
        onTap: () {
          log("item search selected");
          Get.to(OrderDetailPage(
            orderId: item.id,
          ));
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => OrderDetailPage(
          //             order_id: item.id,
          //           )),
          // ).then((value) => _getRequests());
        },
        child: Container(
          padding: EdgeInsets.all(10),
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
                          _buildInfoItemSection(Icons.store, item.storeName),
                          _buildInfoItemSection(
                              Icons.gps_fixed, item.storeAddress.toUpperCase()),
                          _buildInfoItemSection(
                              Icons.person, item.createdByName),
                          _buildInfoItemSection(Icons.timer, item.createdOn),
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
                      color: item.isExportStock == true
                          ? Colors.green
                          : Colors.red,
                    ),
                    child: Text(
                      item.isExportStock == true ? 'Đã duyệt' : 'Chưa duyệt',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ))
          ]),
        ));
  }

  Widget _buildInfoItemSection(IconData iconData, String textInfo) {
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
}
