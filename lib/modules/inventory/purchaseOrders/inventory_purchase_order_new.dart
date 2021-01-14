import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/inventory_purchase_order_new_controller.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

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
      body: Row(
        children: [
          AppDrawer(),
          Expanded(child: _buildBodySection(context)),
        ],
      ),
    );
  }

  Widget _buildAppbarSection(BuildContext context) {
    return AppBar(
      title: Text("CHI TIẾT MUA HÀNG"),
      actions: [
        InkWell(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.save),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'TẠO MỚI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            onTap: () {
              controller.save();
            }),
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
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: NumberInputWithIncrementDecrement(
          controller: product.controller,
          min: 1,
          max: 999999,
          numberFieldDecoration: InputDecoration(border: InputBorder.none),
          initialValue: int.parse(product.controller.text),
        ),
      ),
      InkWell(
        child: Container(
          width: 30,
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

  List<Widget> _buildInformationSection() {
    return [
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
                    'Lưu',
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
        Row(
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
            Container(
              width: 140,
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
          ],
        ),
        Divider(
          thickness: 2,
        ),
        Expanded(
          child: controller.result.value.products == null
              ? Container()
              : ListView.builder(
                  itemCount: controller.result.value.products.length,
                  itemBuilder: (context, index) {
                    return _buildListViewRowSection(
                        controller.result.value.products[index]);
                  },
                ),
        ),
        Divider(
          thickness: 2,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Tổng số lượng ',
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 17,
        //       ),
        //     ),
        //     Text(
        //       controller.getCountSelectedProduct().toString(),
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 17,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     SizedBox(
        //       width: 30,
        //     ),
        //   ],
        // ),
      ],
    );
    // return Container(
    //   padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       RaisedButton(
    //         onPressed: () => controller.addProducts(),
    //         color: Colors.blue,
    //         child: Container(
    //           height: 40,
    //           width: 150,
    //           child: Row(
    //             children: [
    //               Icon(
    //                 Icons.add,
    //                 color: Colors.white,
    //               ),
    //               Text(
    //                 'Thêm sản phẩm',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       controller.result.value.products == null ||
    //               controller.result.value.products.length == 0
    //           // ? Text('abc')
    //           // : Text('xyz')
    //           ? Expanded(
    //               child: ListView.separated(
    //                   shrinkWrap: true,
    //                   separatorBuilder: (context, index) {
    //                     return Divider(
    //                       color: Colors.black,
    //                       thickness: 0.2,
    //                     );
    //                   },
    //                   itemBuilder: (context, index) {
    //                     return Text('');
    //                   },
    //                   itemCount: 1),
    //             )
    //           : Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child: Text(
    //                         'Sản phẩm',
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 15,
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       width: 140,
    //                       child: Text(
    //                         'Số lượng',
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 15,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Divider(
    //                   thickness: 2,
    //                 ),
    //                 Expanded(
    //                   child: ListView.separated(
    //                       separatorBuilder: (context, index) {
    //                         return Divider(
    //                           color: Colors.black,
    //                           thickness: 0.2,
    //                         );
    //                       },
    //                       shrinkWrap: true,
    //                       itemBuilder: (context, index) {
    //                         return _buildListViewRowSection(
    //                             controller.result.value.products[index]);
    //                       },
    //                       itemCount: controller.result.value.products.length),
    //                 ),
    //                 Divider(
    //                   thickness: 2,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   children: [
    //                     Text(
    //                       'Tổng số lượng ',
    //                       style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 17,
    //                       ),
    //                     ),
    //                     Text(
    //                       controller.getCountSelectedProduct().toString(),
    //                       style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: 17,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 30,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //     ],
    //   ),
    // );
  }

  _buildProductSection2() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
      child: Column(
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
          controller.result.value.products == null ||
                  controller.result.value.products.length == 0
              // ? Text('abc')
              // : Text('xyz')
              ? ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.black,
                      thickness: 0.2,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Text('');
                  },
                  itemCount: 1)
              : Column(
                  children: [
                    Row(
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
                        Container(
                          width: 140,
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
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.black,
                            thickness: 0.2,
                          );
                        },
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildListViewRowSection(
                              controller.result.value.products[index]);
                        },
                        itemCount: controller.result.value.products.length),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Tổng số lượng ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          controller.getCountSelectedProduct().toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  _buildBodySection(BuildContext context) {
    return GetX<InventoryPurchaseOrderNewController>(
      init: controller,
      initState: (state) => controller.getId(purchaseOrderId),
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
                        children: [
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                color: Color.fromRGBO(213, 220, 230, 1),
                                child: _buildProductSection()),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: _buildInformationSection(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   color: Color.fromRGBO(213, 220, 230, 1),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Expanded(
                  //         child: _buildProductSection(),
                  //       ),
                  //       ListView(
                  //         children: _buildInformationSection(),
                  //       )
                  //     ],
                  //   ),
                  // ),
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
            controller: controller.thongTinGhiChuTextEditController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

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
            controller: controller.soThamChieuTextEditController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }
}
