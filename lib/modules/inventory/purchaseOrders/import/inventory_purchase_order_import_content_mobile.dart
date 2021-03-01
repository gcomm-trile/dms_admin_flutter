import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'inventory_purchase_order_import_controller.dart';

class InventoryPurchaseOrderImportContentMobile extends StatelessWidget {
  final id;
  final Function(NavigationCallBackModel data) onNavigationChanged;
  InventoryPurchaseOrderImportContentMobile(
      {Key key, @required this.id, this.onNavigationChanged})
      : super(key: key);

  final double widthQuantibox = 80.0;
  final sizedBox = SizedBox(
    width: 10,
  );
  final InventoryPurchaseOrderImportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<InventoryPurchaseOrderImportController>(
        init: controller,
        initState: (state) => controller.getId(id),
        builder: (_) {
          return controller.isBusy.value == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _buildHeaderBarSection(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vendorSection(),
                              stockAndDateSection(context),
                              SizedBox(
                                height: 10,
                              ),
                              _buildHeaderListViewSection(),
                              Divider(
                                thickness: 2,
                              ),
                              controller.products == null
                                  ? Container()
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.products.length,
                                      itemBuilder: (context, index) {
                                        return _buildRowListViewSection(index);
                                      },
                                    ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  stockAndDateSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            width: 70,
            child: Text(
              'Kho',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text(controller.result.value.inStockName)),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 70,
            child: Text(
              'Ngày',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              DateTimeHelper.day2Text(controller.result.value.planDate),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  vendorSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            width: 70,
            child: Text(
              'NPP',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text(controller.result.value.vendorName))
        ],
      ),
    );
  }

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
        child: Text(
          kNumberFormat.format(product.orderPrice) + ' đ',
        ),
      ),
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
            'Giá',
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

  _buildHeaderBarSection() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            'Nhận hàng',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          RaisedButton(
            onPressed: () async {
              var data = await controller.save();
              if (data == true) {
                onNavigationChanged(NavigationCallBackModel(
                    module: DrawModule.INVENTORY_PURCHASE_ORDERS,
                    function: DrawFunction.INDEX,
                    id: ''));
              }
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
}
