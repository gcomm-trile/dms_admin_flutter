import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'inventory_purchase_order_controller.dart';

class InventoryPurchaseOrderPage extends StatelessWidget {
  final InventoryPurchaseOrderController controller =
      InventoryPurchaseOrderController(repository: Get.find());
  InventoryPurchaseOrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        AppDrawer(),
        GetX<InventoryPurchaseOrderController>(
          init: controller,
          initState: (state) => controller.getAll(),
          builder: (_) {
            if (controller.isBusy.value == true)
              return Center(child: CircularProgressIndicator());
            else {
              return Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Danh sách phiếu mua hàng',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              RaisedButton(
                                color: Colors.blue,
                                onPressed: () {
                                  controller.createPurchaseOrder();
                                },
                                child: Container(
                                  height: 37,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Tạo phiếu mua',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('Mã'),
                              Text('Ngày dự kiến'),
                              Text('Nhà phân phối'),
                              Text('Số tham chiếu'),
                              Text('Kho'),
                              Text('Tình trạng'),
                              Text('Số lượng'),
                              Text('Tổng tiền'),
                            ],
                          ),
                          controller.result.value.length == 0
                              ? Center(child: Text('Không có dữ liệu'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.result.value.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text(controller
                                            .result.value[index].no),
                                        Text(controller
                                            .result.value[index].planImportDate
                                            .toString()),
                                        Text(controller
                                            .result.value[index].vendorName),
                                        Text(controller.result.value[index]
                                            .importStockName),
                                        Text(controller
                                            .result.value[index].statusName),
                                        Text(controller
                                            .result.value[index].totalImportQty
                                            .toString()),
                                      ],
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        )
      ],
    ));
  }
}
