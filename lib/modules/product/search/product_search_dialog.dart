import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/modules/product/search/product_search_controller.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSearchDialog extends StatelessWidget {
  final ProductSearchController controller =
      ProductSearchController(repository: Get.find());
  final String stockId;
  final String stockIdIn;
  final String stockIdOut;
  final Function(Set<Product> selectedProducts) savedData;
  ProductSearchDialog(
      {Key key, this.savedData, this.stockId, this.stockIdIn, this.stockIdOut})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(stockIdIn);
    print(stockIdOut);
    return GetX<ProductSearchController>(
        init: controller,
        initState: (state) => controller.getAll(stockIdIn, stockIdOut),
        builder: (_) {
          return Container(
              width: 500.0,
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: controller.isBusy.value == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              TextField(
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                decoration: InputDecoration(
                                    labelText: 'Tìm kiếm sản phẩm',
                                    prefixIcon: Container(
                                        width: 50, child: Icon(Icons.search)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffCED0D2), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Tên sản phẩm',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Kho xuất',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Kho nhập',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                // endIndent: 5,
                                // indent: 5,
                                thickness: 2,
                              ),
                              Expanded(
                                child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                    shrinkWrap: true,
                                    itemCount: controller.result.length,
                                    itemBuilder: (context, index) {
                                      var product = controller.result[index];

                                      return Row(
                                        children: [
                                          Container(
                                              width: 40,
                                              child: Checkbox(
                                                value: product.checked,
                                                checkColor: Colors.white,
                                                activeColor: Colors.blue,
                                                onChanged: (value) {
                                                  controller.setChecked(
                                                      index, value);
                                                },
                                              )),
                                          Image.network(
                                            product.imagePath,
                                            width: kSizeProductImageWidth,
                                            height: kSizeProductImageHeight,
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: Text(
                                              product.name,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            width: 100.0,
                                            child: Text(
                                              kNumberFormat
                                                  .format(product.qtyStockOut),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            width: 100.0,
                                            child: Text(
                                              kNumberFormat
                                                  .format(product.qtyStockIn),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              )
                            ],
                          ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${controller.countChecked()} sản phẩm đã được chọn',
                        style: TextStyle(
                            color: controller.countChecked() > 0
                                ? Colors.blue
                                : Colors.black),
                      ),
                      Expanded(child: Container()),
                      controller.countChecked() > 0
                          ? Container(
                              height: 40,
                              child: RaisedButton(
                                child: Text(
                                  'Hoàn tất chọn',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  this.savedData(
                                      controller.getSelectedProduct());
                                  Navigator.pop(context);
                                  // setState(() {
                                  //   widget.savedData(_checkedProduct);
                                  //   Navigator.pop(context);
                                  // });
                                },
                              ),
                            )
                          : Container(
                              height: 40,
                              child: RaisedButton(
                                child: Text(
                                  'Hoàn tất chọn',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blue,
                              ),
                            ),
                    ],
                  )
                ],
              ));
        });
  }
}
