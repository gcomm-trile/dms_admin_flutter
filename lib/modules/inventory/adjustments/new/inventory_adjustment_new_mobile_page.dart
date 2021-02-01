import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/category_model.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inventory_adjustment_new_controller.dart';

class InventoryAdjustmentNewMobilePage extends StatelessWidget {
  final sizedBox = SizedBox(
    width: 10,
  );
  final id;

  final Function(NavigationCallBackModel data) onNavigationChanged;
  final InventoryAdjustmentNewController controller = Get.find();
  InventoryAdjustmentNewMobilePage(
      {Key key, @required this.id, this.onNavigationChanged})
      : super(key: key);

  Widget build(BuildContext context) {
    return GetX<InventoryAdjustmentNewController>(
      init: controller,
      initState: (state) => controller.getId(id),
      builder: (_) {
        return controller.isBusy.value == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: controller.isNew == true
                        ? Row(
                            children: [
                              Text(
                                'Tạo mới điều chỉnh',
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
                                        module:
                                            DrawModule.INVENTORY_ADJUSTMENTS,
                                        function: DrawFunction.INDEX,
                                        id: id));
                                  }
                                },
                                // onPressed: () async {
                                //  print('000');
                                // controller
                                //     .save()
                                //     .then((data) => print('----------'));
                                // print('1111');
                                // bool value = await controller.save();

                                // if (value == true) {
                                //   print('----------');
                                //   onNavigationChanged(NavigationCallBackModel(
                                //       module:
                                //           DrawModule.INVENTORY_ADJUSTMENTS,
                                //       function: DrawFunction.INDEX,
                                //       id: id));
                                // } else {
                                //   print('xxxxxxxxxxxxxxxxxx');
                                // }
                                // print('doneeeeeeeee');
                                // var result = await controller.save();
                                // if (result == true) {
                                //
                                // }
                                //  },
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
                                        'Điều chỉnh',
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
                        : Row(
                            children: [
                              SizedBox(
                                width: 40,
                              ),
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
                                      '#${TextHelper.toSafeString(controller.result.adjustment.no)}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'NGÀY DỰ KIẾN',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    child: Text(
                                      '${DateTimeHelper.day2Text(controller.result.adjustment.createdOn)}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              RaisedButton(
                                onPressed: () async {
                                  var data = await controller.save();
                                  if (data == true) {
                                    onNavigationChanged(NavigationCallBackModel(
                                        module:
                                            DrawModule.INVENTORY_ADJUSTMENTS,
                                        function: DrawFunction.INDEX,
                                        id: id));
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
                                        'Cập nhật',
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
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
                          child: DropdownSearch<Stock>(
                            mode: Mode.MENU,
                            selectedItem: controller.stock.value,
                            items: controller.result.stocks,
                            itemAsString: (item) => item.name,
                            popupItemBuilder: (context, item, isSelected) {
                              return Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(color: Colors.black),
                                  ));
                            },
                            onChanged: (value) => controller.stock(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          child: Text(
                            'Lí do',
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
                          child: DropdownSearch<CategoryModel>(
                            mode: Mode.MENU,
                            selectedItem: controller.adjustmentReason.value,
                            items: controller.result.adjustmentReasons,
                            itemAsString: (item) => item.name,
                            popupItemBuilder: (context, item, isSelected) {
                              return Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(color: Colors.black),
                                  ));
                            },
                            onChanged: (value) =>
                                controller.adjustmentReason(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(213, 220, 230, 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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

  final double widthQuantibox = 80.0;

  _buildRowListViewSection(int index) {
    var product = controller.products[index];
    var color = product.inQty > 0
        ? Colors.green[700]
        : product.inQty == 0
            ? Colors.black
            : Colors.red[700];

    var textStyle = TextStyle(color: color, fontSize: 15);
    return Row(children: <Widget>[
      Expanded(
        child: Container(child: Text(product.name)),
      ),
      sizedBox,
      Container(
        width: 90,
        padding: EdgeInsets.all(2.0),
        child: NumberInputWithIncrementDecrement(
          scaleHeight: 0.85,
          key: controller.getKey(index),
          controller: TextEditingController(),
          min: -1000,
          max: 1000,
          numberFieldDecoration: InputDecoration(border: InputBorder.none),
          initialValue: product.inQty,
          onChanged: (newValue) => controller.setInQty(index, newValue),
          onDecrement: (newValue) => controller.setInQty(index, newValue),
          onIncrement: (newValue) => controller.setInQty(index, newValue),
        ),
      ),
      sizedBox,
      Container(
        width: 110,
        padding: EdgeInsets.all(0.0),
        child: Row(
          children: [
            Container(
              width: 45,
              child: Text(
                kNumberFormat.format(product.inStockQty),
                style: textStyle,
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              child: Icon(
                Icons.arrow_right_alt,
                color: color,
                size: 20,
              ),
            ),
            Container(
              width: 45,
              child: Text(
                kNumberFormat.format(product.inStockQty + product.inQty),
                style: textStyle,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
      InkWell(
        child: Container(
          width: 25,
          padding: EdgeInsets.only(left: 2.0),
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        onTap: () => controller.removeProduct(product, index),
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
          width: 90,
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
            'Tồn kho',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          width: 25,
        ),
      ],
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
          child: controller.products == null
              ? Container()
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 0.7,
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
              '${controller.products.where((e) => e.inQty != 0).toList().length}',
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
}
