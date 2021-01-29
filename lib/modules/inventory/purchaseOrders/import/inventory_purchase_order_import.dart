import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';

import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inventory_purchase_order_import_controller.dart';

class InventoryPurchaseOrderImportPage extends StatefulWidget {
  final id;

  InventoryPurchaseOrderImportPage({Key key, @required this.id})
      : super(key: key);

  @override
  _InventoryPurchaseOrderImportPageState createState() =>
      _InventoryPurchaseOrderImportPageState();
}

class _InventoryPurchaseOrderImportPageState
    extends State<InventoryPurchaseOrderImportPage> {
  final InventoryPurchaseOrderImportController controller =
      InventoryPurchaseOrderImportController(repository: Get.find());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(selectedModule: 'Mua hàng'),
          Expanded(child: _buildBodySection()),
        ],
      ),
    );
  }

  final double widthQuantibox = 80.0;
  final sizedBox = SizedBox(
    width: 10,
  );
  _buildRowListViewSection(int index) {
    var product = controller.result.value.products[index];

    return Row(children: <Widget>[
      Checkbox(
        value: product.inQty > 0 ? true : false,
        onChanged: (value) {
          print(value);
          controller.setChecked(index, value);

          controller
              .getKey(index)
              .currentState
              .setValue(value == true ? product.orderQty : 0);
        },
      ),
      Image.network(
        product.imagePath,
        width: kSizeProductImageWidth,
        height: kSizeProductImageHeight,
      ),
      sizedBox,
      Expanded(
        child: Container(child: Text(product.name)),
      ),
      sizedBox,
      Container(
          width: 40,
          child: Text(
            kNumberFormat.format(product.orderQty),
          )),
      sizedBox,
      Container(
        width: 120,
        padding: EdgeInsets.all(2.0),
        child: NumberInputWithIncrementDecrement(
          key: controller.getKey(index),
          controller:
              TextEditingController(), // product.qtyImportedTextEditingController,
          min: 0,
          max: product.orderQty,
          numberFieldDecoration: InputDecoration(border: InputBorder.none),
          initialValue: product.inQty,
          onChanged: (value) {
            controller.setInQty(index, value);
          },
          onDecrement: (value) {
            controller.setInQty(index, value);
          },
          onIncrement: (value) {
            controller.setInQty(index, value);
          },
        ),
      ),
      sizedBox,
      Container(
        width: 80,
        child: Row(
          children: [
            Container(
              width: 25,
              child: Text(
                '${product.inStockQty}',
                textAlign: TextAlign.end,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 20,
              child: Icon(Icons.arrow_right_alt),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 25,
              child: Text(
                '${product.inStockQty + product.inQty}',
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
      sizedBox,
      Container(
        width: 80,
        child: Text(
          kNumberFormat.format(product.orderPrice) + ' đ',
        ),
      ),
      sizedBox,
      Container(
        width: 100,
        child: Text(
          kNumberFormat.format(product.orderPrice * product.inQty) + ' đ',
        ),
      )
    ]);
  }

  _buildHeaderListViewSection() {
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
          width: 40,
          child: Text(
            'Đặt',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 120,
          child: Text(
            'Nhận',
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
          width: 80,
          child: Text(
            'Trong kho',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 80,
          child: Text(
            'Giá',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 100,
          child: Text(
            'Thành tiền',
            textAlign: TextAlign.start,
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

  List<Widget> _buildInformationSection() {
    return [
      _buildVendorSection(),
      SizedBox(
        height: 10,
      ),
      _buildStockSection(),
      SizedBox(
        height: 10,
      ),
      _buildAdditionalSection(),
      SizedBox(
        height: 10,
      )
    ];
  }

  _buildHeaderBarSection() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            'Chi tiết phiếu mua hàng',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          RaisedButton(
            onPressed: () {
              controller.import();
            },
            color: Colors.blue,
            child: Container(
              height: 40,
              width: 100,
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  Text(
                    'NHẬN',
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
          child: controller.products == null
              ? Container()
              : ListView.builder(
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
              '${controller.getProductImported()}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Số lượng nhập: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Text(
              '${controller.getQtyImported()}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Tổng tiền: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Text(
              '${kNumberFormat.format(controller.getTotalMoneyImported())} đ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }

  _buildBodySection() {
    return GetX<InventoryPurchaseOrderImportController>(
      init: controller,
      initState: (state) => controller.getId(widget.id),
      builder: (_) {
        return controller.isBusy.value == true
            ? Center(child: CircularProgressIndicator())
            : Column(
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
                          Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildInformationSection(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  _buildStockSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(5),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.stock.value.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildVendorSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nhà Phân Phối',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.vendor.value.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              controller.isExpandedVendor.value == false
                  ? FlatButton(
                      onPressed: () => controller.setExpandedVendor(true),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            Text(
                              'Xem thêm',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FlatButton(
                          onPressed: () => controller.setExpandedVendor(false),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.format_indent_decrease,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Thu gọn',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          'Thông tin nhà phân phối',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.vendor.value.phone,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.address,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.ward,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.district,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.province,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.country,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  _buildAdditionalSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông Tin Bổ Sung',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Text(
            'Ngày dự kiến',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Container(
            child:
                Text(DateTimeHelper.day2Text(controller.result.value.planDate)),
          ),
        ],
      ),
    );
  }
}
