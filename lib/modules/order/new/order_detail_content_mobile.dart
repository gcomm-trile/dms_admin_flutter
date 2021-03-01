import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/color_helper.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:get/get.dart';
import 'order_detail_controller.dart';

// ignore: must_be_immutable
class OrderDetailContentMobile extends StatelessWidget {
  final OrderDetailController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;
  final String id;
  bool enabled = true;

  final SizedBox sizedBox = SizedBox(
    width: 10,
  );
  OrderDetailContentMobile({
    Key key,
    @required this.id,
    @required this.onNavigationChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: GetX<OrderDetailController>(
            initState: (state) => controller.getId(id),
            // init: Get.find<OrderController>().getId(orderId),
            builder: (_c) {
              return (controller.isBusy.value == true)
                  ? LoadingControl()
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: Stack(children: [
                        Column(
                          children: [
                            _buildHeaderBarSection(),
                            _buildInfoSection(controller),
                            _buildDivider,
                            _buildHeaderListView,
                            _buildDivider,
                            Expanded(
                                child: _buildListView(
                                    controller.result.value.products))
                          ],
                        ),
                        // Positioned.fill(
                        //     child: Align(
                        //         alignment: Alignment.topRight,
                        //         child: AbsorbPointer(
                        //           absorbing: !enabled,
                        //           child: InkWell(
                        //               onTap: () => controller.approved(),
                        //               child: Icon(Icons.approval, size: 50)),
                        //         ))),
                      ]),
                    );
            }));
  }

  _buildHeaderBarSection() {
    return Container(
      padding: EdgeInsets.all(20),
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
                            controller.result.value.isExportStock == true
                                ? 'Đã xuất'
                                : 'Chưa xuất'),
                        style: TextStyle(
                          color: Colors.white,
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
          controller.result.value.isExportStock == true
              ? RaisedButton(
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
                          'Xuất hàng',
                          // controller.result.value.status == 2
                          //     ? 'Xác nhận nhập'
                          //     : 'Hoàn nhập',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : RaisedButton(
                  onPressed: () async {
                    var data = await controller.save(id);
                    if (data == true) {
                      onNavigationChanged(NavigationCallBackModel(
                          module: DrawModule.ORDERS,
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
                          'Xuất hàng',
                          // controller.result.value.status == 2
                          //     ? 'Xác nhận nhập'
                          //     : 'Hoàn nhập',
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

  Widget _buildInfoSection(OrderDetailController orderController) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.store,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(orderController.result.value.storeName),
              ),
              Container(
                child: Icon(
                  Icons.phone,
                  size: kIconSize,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(orderController.result.value.contactPerson),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.gps_fixed,
                  size: kIconSize,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(orderController.result.value.storeAddress),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.person,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(orderController.result.value.createdByName),
              ),
              Container(
                child: Icon(
                  Icons.timer,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(orderController.result.value.createdOn),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.inventory,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(orderController.result.value.exportStockName),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _buildDivider {
    return Divider(
      thickness: 1.5,
      color: Colors.black,
    );
  }

  Widget _buildListView(List<Product> data) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index < data.length) {
            return _buildRowListView(data[index], index);
          } else {
            double sum = 0.0;
            data.forEach((e) => sum += (e.orderQty * e.orderPrice));
            return Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Tổng : " + kNumberFormat.format(sum) + " đ",
                textAlign: TextAlign.end,
                style: kStyleListViewHeader,
              ),
            );
          }
        },
        separatorBuilder: (context, index) {
          if (index < data.length - 1) {
            return Divider(
              thickness: 1.5,
              color: kPrimaryLightColor,
            );
          } else {
            return _buildDivider;
          }
        },
        itemCount: data.length + 1);
  }

  Widget get _buildHeaderListView {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Container(
              child: Text(
                "Tên SP",
                style: kStyleListViewHeader,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: 40,
              child: Container(
                  child: Text(
                "SL",
                style: kStyleListViewHeader,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
              width: 70,
              child: Container(
                  child: Text(
                "Đơn giá",
                style: kStyleListViewHeader,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
              width: 100,
              child: Container(
                  child: Text(
                "Thành tiền",
                style: kStyleListViewHeader,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }

  Widget _buildRowListView(Product item, int index) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  (index + 1).toString() + '.',
                  style: kStyleListViewHeader,
                )),
          ),
          Expanded(
            child: Container(
              child: Text(
                item.name,
                style: kStyleListViewItem,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: 40,
              child: Container(
                  child: Text(
                kNumberFormat.format(item.orderQty),
                style: kStyleListViewItem,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
              width: 70,
              child: Container(
                  child: Text(
                kNumberFormat.format(item.orderPrice),
                style: kStyleListViewItem,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
              width: 100,
              child: Container(
                  child: Text(
                kNumberFormat.format((item.orderPrice * item.orderQty)),
                style: kStyleListViewItem,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }

  Widget buildInfoSection(Order data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.store,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(data.storeName),
              ),
              Container(
                child: Icon(
                  Icons.phone,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text('0936287592'),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.gps_fixed,
                  size: kIconSize,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(data.storeAddress),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.person,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(data.createdByName),
              ),
              Container(
                child: Icon(
                  Icons.timer,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(data.createdOn),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.inventory,
                  size: kIconSize,
                ),
              ),
              Container(
                child: Text(data.exportStockId == kDefaultGuildId
                    ? 'Chưa có kho xuất'
                    : data.exportStockName),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Icon(
                    Icons.search,
                    size: kIconSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class OrderDetailPage extends StatefulWidget {
//   final String orderId;
//   OrderDetailPage({Key key, this.orderId}) : super(key: key);

//   @override
//   _OrderDetailPageState createState() => _OrderDetailPageState();
// }

// class _OrderDetailPageState extends State<OrderDetailPage> {
//   Future<Order> f_data;
//   final formatter = new NumberFormat("#,###");

//   bool enabled = true;
//   Order data;
//   @override
//   void initState() {
//     super.initState();
//     print('run order : ' + widget.orderId);
//     f_data = API_HELPER.getOrder(widget.orderId);
//   }

//   Widget get _buildDivider {
//     return Divider(
//       thickness: 1.5,
//       color: Colors.black,
//     );
//   }

//   Widget _buildInfoItem(IconData iconData, String textInfo) {
//     return Container(
//       child: Row(
//         children: [
//           Icon(iconData),
//           Flexible(
//             child: Text(textInfo),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImportStockSection(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10.0),
//       child: Row(
//         children: [
//           Text(
//             "Kho nhận:",
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             width: 10.0,
//           ),
//           Text("Hello",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold)),
//           SizedBox(
//             width: 10.0,
//           ),
//           GestureDetector(
//             onTap: () => _showPopupSearchStock(context),
//             child: Container(
//               child: Icon(
//                 Icons.search,
//                 size: 50,
//                 color: kPrimaryColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoSection(Order data) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 child: Icon(
//                   Icons.store,
//                   size: kIconSize,
//                 ),
//               ),
//               Container(
//                 child: Text(data.storeName),
//               ),
//               Container(
//                 child: Icon(
//                   Icons.phone,
//                   size: kIconSize,
//                 ),
//               ),
//               Container(
//                 child: Text('0936287592'),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Container(
//                 child: Icon(
//                   Icons.gps_fixed,
//                   size: kIconSize,
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   child: Text(data.storeAddress),
//                 ),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Container(
//                 child: Icon(
//                   Icons.person,
//                   size: kIconSize,
//                 ),
//               ),
//               Container(
//                 child: Text(data.createdByName),
//               ),
//               Container(
//                 child: Icon(
//                   Icons.timer,
//                   size: kIconSize,
//                 ),
//               ),
//               Container(
//                 child: Text(data.createdOn),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Container(
//                 child: Icon(
//                   Icons.inventory,
//                   size: kIconSize,
//                 ),
//               ),
//               Container(
//                 child: Text(data.exportStockId == kDefaultGuildId
//                     ? 'Chưa có kho xuất'
//                     : data.exportStockName),
//               ),
//               InkWell(
//                 onTap: () => _showPopupSearchStock(context),
//                 child: Container(
//                   child: Icon(
//                     Icons.search,
//                     size: kIconSize,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return KeyboardDismisser(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Chi tiết đơn hàng'),
//           actions: [
//             AbsorbPointer(
//               absorbing: !enabled,
//               child: InkWell(
//                   onTap: () => _approved(),
//                   child: Icon(Icons.approval, size: 50)),
//             )
//           ],
//         ),
//         body: FutureBuilder<Order>(
//           future: f_data,
//           builder: (context, snapshot) {
//             if (snapshot.hasData == true) {
//               data = snapshot.data;
//               return Stack(children: [
//                 Column(
//                   children: [
//                     _buildInfoSection(data),
//                     _buildDivider,
//                     _buildHeaderListView,
//                     _buildDivider,
//                     Expanded(child: _buildListView(data.products))
//                   ],
//                 ),
//                 Positioned.fill(
//                     child: Align(
//                   alignment: Alignment.topRight,
//                   child: Opacity(
//                       opacity: 0.5,
//                       child: Image.asset(
//                         data.isExportStock == true
//                             ? ('assets/images/approved.jpg')
//                             : ('assets/images/pending.jpg'),
//                         height: 150,
//                         width: 150,
//                       )),
//                 )),
//               ]);
//             } else if (snapshot.hasError == true) {
//               return Center(child: Text("${snapshot.error}"));
//             } else {
//               return LoadingControl();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildListView(List<Product> data) {
//     return ListView.separated(
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           if (index < data.length) {
//             return _buildRowListView(data[index], index);
//           } else {
//             double sum = 0.0;
//             data.forEach((e) => sum += (e.qty * e.price));
//             return Expanded(
//                 child: Container(
//               margin: EdgeInsets.all(10.0),
//               child: Text(
//                 "Tổng : " + formatter.format(sum) + " đ",
//                 textAlign: TextAlign.end,
//                 style: kStyleListViewHeader,
//               ),
//             ));
//           }
//         },
//         separatorBuilder: (context, index) {
//           if (index < data.length - 1) {
//             return Divider(
//               thickness: 1.5,
//               color: kPrimaryLightColor,
//             );
//           } else {
//             return _buildDivider;
//           }
//         },
//         itemCount: data.length + 1);
//   }

//   Widget get _buildHeaderListView {
//     return Container(
//       child: Row(
//         children: [
//           SizedBox(
//             width: 30,
//           ),
//           Expanded(
//             child: Container(
//               child: Text(
//                 "Tên SP",
//                 style: kStyleListViewHeader,
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ),
//           SizedBox(
//               width: 40,
//               child: Container(
//                   child: Text(
//                 "SL",
//                 style: kStyleListViewHeader,
//                 textAlign: TextAlign.center,
//               ))),
//           SizedBox(
//               width: 70,
//               child: Container(
//                   child: Text(
//                 "Đơn giá",
//                 style: kStyleListViewHeader,
//                 textAlign: TextAlign.right,
//               ))),
//           SizedBox(
//               width: 100,
//               child: Container(
//                   child: Text(
//                 "Thành tiền",
//                 style: kStyleListViewHeader,
//                 textAlign: TextAlign.right,
//               ))),
//           SizedBox(
//             width: 5.0,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRowListView(Product item, int index) {
//     return Container(
//       child: Row(
//         children: [
//           SizedBox(
//             width: 35,
//             child: Container(
//                 margin: EdgeInsets.only(left: 10.0),
//                 child: Text(
//                   (index + 1).toString() + '.',
//                   style: kStyleListViewHeader,
//                 )),
//           ),
//           Expanded(
//             child: Container(
//               child: Text(
//                 item.name,
//                 style: kStyleListViewItem,
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ),
//           SizedBox(
//               width: 40,
//               child: Container(
//                   child: Text(
//                 formatter.format(item.qty),
//                 style: kStyleListViewItem,
//                 textAlign: TextAlign.center,
//               ))),
//           SizedBox(
//               width: 70,
//               child: Container(
//                   child: Text(
//                 formatter.format(item.price),
//                 style: kStyleListViewItem,
//                 textAlign: TextAlign.right,
//               ))),
//           SizedBox(
//               width: 100,
//               child: Container(
//                   child: Text(
//                 formatter.format((item.price * item.qty)),
//                 style: kStyleListViewItem,
//                 textAlign: TextAlign.right,
//               ))),
//           SizedBox(
//             width: 5.0,
//           ),
//         ],
//       ),
//     );
//   }

//   void _showPopupSearchStock(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: StockSearchPage(
//               savedData: (selectedStock) {
//                 setState(() {
//                   data.exportStockId = selectedStock.id;
//                   data.exportStockName = selectedStock.name;
//                 });
//               },
//             ),
//           );
//         });
//   }

//   _approved() {
//     if (data.exportStockId == kDefaultGuildId) {
//       UI.showError("Chưa chọn kho xuất");
//       return;
//     }

//     enabled = !enabled;

//     API_HELPER
//         .postDuyetXuatDonHang(widget.orderId, data.exportStockId, 1)
//         .then((value) {
//       if (value.isEmpty) {
//         UI.showSuccess("Đã cập nhật thành công");
//         Navigator.pop(context);
//       } else {
//         UI.showError(value);
//         enabled = !enabled;
//       }
//     });
//   }
// }
