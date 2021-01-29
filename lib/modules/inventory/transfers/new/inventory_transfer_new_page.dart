import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/global_widgets/number_input_with_increment_decrement.dart';
import 'package:dms_admin/utils/color_helper.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:get/get.dart';

import 'inventory_transfer_new_controller.dart';

class InventoryTransferNewPage extends StatelessWidget {
  final sizedBox = SizedBox(
    width: 10,
  );
  final double widthQuantibox = 80.0;
  final id;
  dp.DatePickerStyles styles;
  InventoryTransferNewController controller =
      InventoryTransferNewController(repository: Get.find());
  InventoryTransferNewPage({Key key, @required this.id}) : super(key: key);
  Widget build(BuildContext context) {
    styles = dp.DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: Colors.white),
        selectedSingleDateDecoration:
            BoxDecoration(color: Colors.blue, shape: BoxShape.circle));

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
      Image.network(
        product.imagePath,
        width: kSizeProductImageWidth,
        height: kSizeProductImageHeight,
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(child: Text(TextHelper.toSafeString(product.name))),
      ),
      sizedBox,
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: NumberInputWithIncrementDecrement(
          key: controller.getKey(index),
          controller: TextEditingController(),
          min: 0,
          max: 999999,
          numberFieldDecoration: InputDecoration(border: InputBorder.none),
          initialValue: product.outQty,
          onChanged: (value) => controller.setQtyOrder(index, value),
          onDecrement: (value) => controller.setQtyOrder(index, value),
          onIncrement: (value) => controller.setQtyOrder(index, value),
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
              ),
            ),
            Container(
              child: Icon(Icons.arrow_right_alt),
            ),
            Container(
              width: 40,
              child: Text(
                kNumberFormat.format(product.outStockQty - product.outQty),
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
              ),
            ),
            Container(
              child: Icon(Icons.arrow_right_alt),
            ),
            Container(
              width: 40,
              child: Text(
                kNumberFormat.format(product.inStockQty + product.outQty),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
      sizedBox,
      InkWell(
        child: Container(
          width: 30,
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
        sizedBox,
        SizedBox(
          width: 30,
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
          controller.result.value.products == null
              ? Text(
                  'Chi tiết phiếu điều chuyển',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Row(
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
                            '#${TextHelper.toSafeString(controller.result.value.no)}',
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
                  ],
                ),
          Expanded(child: Container()),
          RaisedButton(
            onPressed: () {
              controller.save(1);
            },
            color: Colors.red,
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
                    'Lưu trữ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sizedBox,
          RaisedButton(
            onPressed: () {
              controller.save(2);
            },
            color: Colors.blue,
            child: Container(
              height: 40,
              width: 140,
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  Text(
                    'Lưu & Xuất hàng',
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
        Expanded(
          child: controller.products == null || controller.products.length == 0
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
              '${controller.products.length}',
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
              'Tổng số lượng: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Text(
              '${controller.getQtyOut()}',
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

  _buildBodySection(BuildContext context) {
    return GetX<InventoryTransferNewController>(
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
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 160,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  stockSection(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(child: additionalSection(context)),
                                ]
                                // _buildInformationSection(160, context),
                                ),
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
                Text('Kho xuất'),
                DropdownButton<String>(
                  value: controller.selectedOutStock.value,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    controller.setOutStock(newValue);
                  },
                  items: controller.outStocks
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Text('Kho nhận'),
                DropdownButton<String>(
                  value: controller.selectedInStock.value,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    controller.setStockImport(newValue);
                  },
                  items: controller.inStocks
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
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
      padding: EdgeInsets.all(5),
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
            controller: controller.thongTinGhiChuTextEditController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

  additionalSection(BuildContext context) {
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
            'Ngày dự kiến',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
