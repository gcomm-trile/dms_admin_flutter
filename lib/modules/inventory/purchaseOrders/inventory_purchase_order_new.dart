import 'package:dms_admin/components/header_listview_product.dart';
import 'package:dms_admin/global_widgets/text_input.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/inventory_purchase_order_new_controller.dart';
import 'package:dms_admin/components/qty_textfield.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:get/get.dart';

class InventoryPurchaseOrderNewPage extends StatelessWidget {
  final purchaseOrderId;
  dp.DatePickerStyles styles;
  InventoryPurchaseOrderNewController controller =
      InventoryPurchaseOrderNewController(repository: Get.find());
  InventoryPurchaseOrderNewPage({Key key, @required this.purchaseOrderId})
      : super(key: key);
  Widget build(BuildContext context) {
    styles = dp.DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: Colors.white),
        selectedSingleDateDecoration:
            BoxDecoration(color: Colors.blue, shape: BoxShape.circle));

    return Scaffold(
      appBar: _buildAppbarSection(context),
      body: _buildBodySection(context),
    );
  }

  Widget _buildAppbarSection(BuildContext context) {
    return AppBar(
      title: Text("MUA HÀNG"),
      actions: [
        InkWell(
            child: Container(
                width: 50,
                child: Icon(
                  Icons.approval,
                  size: 50.0,
                )),
            onTap: () {}),
      ],
    );
  }

  final double widthQuantibox = 80.0;

  void _removeProduct(Product product) {
    // setState(() {
    //   data.products.remove(product);
    // });
  }

  Widget _buildListViewRowSection(Product product) {
    return Row(children: <Widget>[
      InkWell(
        child: Container(
          width: 20,
          padding: EdgeInsets.only(left: 2.0),
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        onTap: () => _removeProduct(product),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(child: Text(product.name)),
      ),
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: QtyTextField(
          value: product.qty,
          minValue: 0,
          maxValue: 9999,
          onChangedValue: (value) {
            product.qty = value;
          },
        ),
      )
    ]);
  }

  _buildBodySection(BuildContext context) {
    return GetX<InventoryPurchaseOrderNewController>(
      init: controller,
      initState: (state) => controller.getId(purchaseOrderId),
      builder: (_) {
        return controller.isBusy.value == true
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(213, 220, 230, 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RaisedButton(
                                onPressed: () => controller.addProducts(),
                                color: Colors.blue,
                                child: Container(
                                  width: 160,
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
                              Row(
                                children: [
                                  Text('Sản phẩm'),
                                  Text('Số lượng'),
                                  Text('Giá'),
                                  Text('Tổng tiền'),
                                ],
                              ),
                            ],
                          ),
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vendorSection(),
                            SizedBox(
                              height: 10,
                            ),
                            stockSection(),
                            SizedBox(
                              height: 10,
                            ),
                            noteSection(),
                            SizedBox(
                              height: 10,
                            ),
                            additionalSection(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    )),
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
      padding: EdgeInsets.all(20),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Kho',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              controller.stock.value == null
                  ? Container(
                      width: 40,
                      height: 40,
                    )
                  : Container(
                      width: 40,
                      height: 40,
                      child: RaisedButton(
                        onPressed: () => controller.setStock(''),
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ),
            ],
          ),
          Divider(),
          controller.stock.value == null
              ? DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  items: controller.getAllStocks(),
                  label: "",
                  hint: "",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (value) => controller.setStock(value),
                  showSearchBox: true,
                )
              : Column(
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

  vendorSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(20),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Nhà Phân Phối',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              controller.vendor.value == null
                  ? Container(
                      width: 40,
                      height: 40,
                    )
                  : Container(
                      width: 40,
                      height: 40,
                      child: RaisedButton(
                        onPressed: () => controller.setVendor(''),
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ),
            ],
          ),
          Divider(),
          controller.vendor.value == null
              ? DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  items: controller.getAllVendors(),
                  label: "",
                  hint: "",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (value) => controller.setVendor(value),
                  showClearButton: true,
                  showSearchBox: true,
                )
              : Column(
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
                                onPressed: () =>
                                    controller.setExpandedVendor(false),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                )
        ],
      ),
    );
  }

  noteSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(20),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông Tin Ghi Chú',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

  DateTime _selectedDate = DateTime.now();
  additionalSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(20),
      width: 250,
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
            height: 250,
            child: dp.DayPicker.single(
              selectedDate: controller.planImportDate.value,
              onChanged: (value) {
                print(value.toString());
                controller.setPlanImportDate(value);
              },
              firstDate: DateTime.now().add(new Duration(days: -1000)),
              lastDate: DateTime.now().add(new Duration(days: 1000)),
              datePickerStyles: styles,
              datePickerLayoutSettings: dp.DatePickerLayoutSettings(
                  maxDayPickerRowCount: 2,
                  showPrevMonthEnd: true,
                  showNextMonthStart: true),
              // selectableDayPredicate: _isSelectableCustom,
              // eventDecorationBuilder: _eventDecorationBuilder,
            ),
          ),
          Text(
            'Số tham chiếu',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }
}
