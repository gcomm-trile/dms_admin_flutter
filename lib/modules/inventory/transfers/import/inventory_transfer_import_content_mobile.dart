import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/utils/color_helper.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inventory_transfer_import_controller.dart';

class InventoryTransferImportContentMobile extends StatelessWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  final sizedBox = SizedBox(
    width: 10,
  );
  final double widthQuantibox = 80.0;
  final id;

  final InventoryTransferImportController controller = Get.find();
  InventoryTransferImportContentMobile(
      {Key key, @required this.id, this.onNavigationChanged})
      : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      child: GetX<InventoryTransferImportController>(
        init: controller,
        initState: (state) => controller.getId(id),
        builder: (_) {
          return controller.isBusy.value == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'MÃ PHIẾU',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        child: Text(
                                          TextHelper.toSafeString(
                                              controller.result.value.no),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBox,
                                  Column(
                                    children: [
                                      Text(
                                        'NGÀY NHẬN',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        child: Text(
                                          DateTimeHelper.day2Text(
                                              controller.result.value.planDate),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBox,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'TRẠNG THÁI',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2.5),
                                          color: ColorHelper.fromHex("#e8ae0e"),
                                        ),
                                        padding: EdgeInsets.all(3.0),
                                        child: Text(
                                          TextHelper.toSafeString(controller
                                              .result.value.statusName),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  sizedBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'KHO',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            TextHelper.toSafeString(controller
                                                .result.value.outStockName),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(Icons.arrow_right_alt),
                                          Text(
                                            TextHelper.toSafeString(controller
                                                .result.value.inStockName),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Color.fromRGBO(213, 220, 230, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    color: Color.fromRGBO(213, 220, 230, 1),
                                    child: _buildProductSection()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(selectedModule: 'Điều chuyển'),
          Expanded(child: _buildBodySection(context)),
        ],
      ),
    );
  }

  _buildRowListViewSection(int index) {
    var product = controller.products[index];

    return Row(children: <Widget>[
      Expanded(
        child: Container(child: Text(TextHelper.toSafeString(product.name))),
      ),
      sizedBox,
      Container(
        width: 60,
        padding: EdgeInsets.all(2.0),
        child: Text(
          kNumberFormat.format(product.outQty),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      sizedBox,
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: Row(
          children: [
            Container(
              width: 40,
              child: Text(
                kNumberFormat.format(product.outStockQty),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              child: Icon(
                Icons.arrow_right_alt,
                color: Colors.red,
              ),
            ),
            Container(
              width: 40,
              child: Text(
                kNumberFormat.format(product.outStockQty - product.outQty),
                style: TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
      sizedBox,
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: Row(
          children: [
            Container(
              width: 40,
              child: Text(
                kNumberFormat.format(product.inStockQty),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            Container(
              child: Icon(
                Icons.arrow_right_alt,
                color: Colors.green,
              ),
            ),
            Container(
              width: 40,
              child: Text(
                kNumberFormat.format(product.inStockQty + product.outQty),
                style: TextStyle(
                  color: Colors.green,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildHeaderListViewSection() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Sản phẩm',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 60,
          child: Text(
            'SL',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 110,
          child: Text(
            'Kho xuất',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 110,
          child: Text(
            'Kho nhập',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  _buildHeaderBarSection() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      'MÃ PHIẾU',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 25,
                      child: Text(
                        TextHelper.toSafeString(controller.result.value.no),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                sizedBox,
                Column(
                  children: [
                    Text(
                      'NGÀY NHẬN',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 25,
                      child: Text(
                        DateTimeHelper.day2Text(
                            controller.result.value.planDate),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                sizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRẠNG THÁI',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: ColorHelper.fromHex("#e8ae0e"),
                      ),
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        TextHelper.toSafeString(
                            controller.result.value.statusName),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                sizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KHO',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          TextHelper.toSafeString(
                              controller.result.value.outStockName),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_right_alt),
                        Text(
                          TextHelper.toSafeString(
                              controller.result.value.inStockName),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              controller.save();
            },
            color: Colors.blueAccent,
            child: Container(
              height: 40,
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  Text(
                    controller.result.value.status == 2
                        ? 'Xác nhận nhập'
                        : 'Hoàn nhập',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildProductSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildHeaderListViewSection(),
        Divider(
          thickness: 2,
        ),
        Expanded(
          child: controller.products == null || controller.products.length == 0
              ? Container()
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 0.5,
                    color: Colors.black,
                  ),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    return _buildRowListViewSection(index);
                  },
                ),
        ),
        Divider(
          thickness: 2,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Số sản phẩm: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '${controller.products.length}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Tổng số lượng: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '${controller.sumQtyOut()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Expanded(child: Container()),
            RaisedButton(
              onPressed: () async {
                var data = await controller.save();
                if (data == true) {
                  onNavigationChanged(NavigationCallBackModel(
                      module: DrawModule.INVENTORY_TRANSFERS,
                      function: DrawFunction.INDEX,
                      id: ''));
                }
              },
              color: Colors.blueAccent,
              child: Container(
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Text(
                      controller.result.value.status == 2
                          ? 'Xác nhận nhập'
                          : 'Hoàn nhập',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildBodySection(BuildContext context) {
    return GetX<InventoryTransferImportController>(
      init: controller,
      initState: (state) => controller.getId(id),
      builder: (_) {
        return controller.isBusy.value == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderBarSection(),
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(213, 220, 230, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                color: Color.fromRGBO(213, 220, 230, 1),
                                child: _buildProductSection()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  stockSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(5),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kho',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Từ kho'),
                Text('Kho 1.'),
                Text('Đến kho'),
                Text('Kho 32'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
