import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/new/inventory_purchase_order_new_controller.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InventoryPurchaseOrderNewContentMobile extends StatelessWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  final sizedBox = SizedBox(width: 10);
  final double widthQuantibox = 80.0;
  final id;
  final InventoryPurchaseOrderNewController controller = Get.find();
  InventoryPurchaseOrderNewContentMobile(
      {Key key, @required this.id, this.onNavigationChanged})
      : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      child: GetX<InventoryPurchaseOrderNewController>(
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
                              RaisedButton(
                                onPressed: () => controller.addProducts(),
                                color: Colors.blue,
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Thêm sản phẩm',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                                    '${controller.getProductOrder()}',
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
                                    '${controller.getQtyOrder()}',
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
                                    '${kNumberFormat.format(controller.getTotalMoneyOrder())} đ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
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

  _buildRowListViewSection(int index) {
    var product = controller.products[index];
    return Row(children: <Widget>[
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(child: Text(product.name)),
      ),
      sizedBox,
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: NumberInputWithIncrementDecrement(
          key: controller.getKey(index),
          controller: TextEditingController(),
          // controller: product.qtyTextEditingController,
          min: 0,
          max: 999999,
          numberFieldDecoration: InputDecoration(border: InputBorder.none),
          initialValue: product.orderQty,
          onChanged: (value) => controller.setQtyOrder(index, value),
          onDecrement: (value) => controller.setQtyOrder(index, value),
          onIncrement: (value) => controller.setQtyOrder(index, value),
        ),
      ),
      sizedBox,
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)),
          ),
          controller: product.priceOrderEditingController,
          onChanged: (value) {
            product.priceOrderEditingController.text = value;
            controller.setPriceImported(index, value);
          },
          keyboardType: TextInputType.number,
        ),
      ),
      sizedBox,
      InkWell(
        child: Container(
          width: 40,
          padding: EdgeInsets.only(left: 2.0),
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        onTap: () => controller.removeProduct(index),
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
          width: 110,
          child: Text(
            'Số lượng',
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
            'Đơn giá',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        SizedBox(
          width: 40,
        ),
      ],
    );
  }

  _buildHeaderBarSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Text(
            'Chi tiết mua hàng',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: RaisedButton(
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
                      'Lưu',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
          Expanded(
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItem: true,
              items: controller.getAllStocks(),
              label: "",
              hint: "",
              onChanged: (value) => controller.setStock(value),
              showSearchBox: true,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 70,
            child: Text(
              'Ngày dự kiến',
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
            child: RaisedButton(
              child: Text(
                DateTimeHelper.day2Text(controller.planDate.value),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                final DateTime pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.planDate.value,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2050));
                if (pickedDate != null &&
                    pickedDate != controller.planDate.value)
                  controller.planDate(pickedDate);
              },
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
              'Nhà Phân Phối',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItem: true,
              items: controller.getAllVendors(),
              label: "",
              hint: "",
              // popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (value) => controller.setVendor(value),
              showClearButton: false,
              showSearchBox: true,
            ),
          )
        ],
      ),
    );
  }
}
