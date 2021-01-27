import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inventory_adjustment_new_controller.dart';

class InventoryAdjustmentNewPage extends StatelessWidget {
  final sizedBox = SizedBox(
    width: 10,
  );
  final id;

  final InventoryAdjustmentNewController controller =
      InventoryAdjustmentNewController(repository: Get.find());
  InventoryAdjustmentNewPage({Key key, @required this.id}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(),
          Expanded(child: _buildBodySection(context)),
        ],
      ),
    );
  }

  final double widthQuantibox = 80.0;

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
        child: Container(child: Text(product.name)),
      ),
      sizedBox,
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: NumberInputWithIncrementDecrement(
          key: UniqueKey(),
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
                kNumberFormat.format(product.inStockQty + product.inQty),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
      sizedBox,
      InkWell(
        child: Container(
          width: 25,
          padding: EdgeInsets.only(left: 2.0),
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        onTap: () => controller.removeProduct(product),
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

  _buildHeaderBarSection() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            'Chi tiết phiếu điều chỉnh',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          RaisedButton(
            onPressed: () {
              controller.save();
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

  _buildBodySection(BuildContext context) {
    return GetX<InventoryAdjustmentNewController>(
      init: controller,
      initState: (state) => controller.getId(id),
      builder: (_) {
        print('rebuild');
        return controller.isBusy.value == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildHeaderBarSection(),
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
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white70,
                            ),
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Kho',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: controller.stock.value.id,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (newValue) {
                                    controller.setStock(newValue);
                                  },
                                  items: controller.result.value.stocks
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.id,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                              ],
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
          Row(
            children: [
              Text(
                'Kho',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: controller.stock.value.id,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (newValue) {
                  controller.setStock(newValue);
                },
                items: controller.result.value.stocks
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.id,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
