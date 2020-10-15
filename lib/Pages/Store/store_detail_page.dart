import 'dart:developer';

import 'package:dms_admin/Pages/Store/store_detail_controller.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreDetailPage extends StatelessWidget {
  final String storeId;
  final StoreDetailController storeDetailController =
      Get.put(StoreDetailController());
  StoreDetailPage({Key key, this.storeId}) : super(key: key) {
    storeDetailController.setStoreId(this.storeId);
  }
  @override
  Widget build(BuildContext context) {
    return GetX<StoreDetailController>(
      builder: (controller) {
        return controller.isLoading.value == LoadStatus.loading
            ? Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ],
              )
            : Container(
                width: 300.0,
                child: ListView(children: <Widget>[
                  _createRowTitle('Tên cửa hàng'),
                  _createRowData(controller.data.value.name),
                  _createRowTitle('Chủ cửa hàng'),
                  _createRowData(controller.data.value.owner),
                  _createRowTitle('Điện thoại'),
                  _createRowData(controller.data.value.phone),
                  _createRowTitle('Tỉnh/TP'),
                  _createRowData(controller.data.value.province),
                  _createRowTitle('Quận/Huyện'),
                  _createRowData(controller.data.value.district),
                  _createRowTitle('Phường/Xã'),
                  _createRowData(controller.data.value.ward),
                  _createRowTitle('Số nhà/Đường...'),
                  _createRowData(controller.data.value.address),
                ]),
              );
      },
    );
  }

  _createRowTitle(String value) {
    return Container(
      child: Text(value),
    );
  }

  _createRowData(String value) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.teal[200],
        ),
        child: Text(value));
  }
}
