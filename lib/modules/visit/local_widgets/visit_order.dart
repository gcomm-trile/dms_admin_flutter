import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/modules/visit/visit_controller.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VisitOrder extends GetView<VisitController> {
  const VisitOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(controller.visit.order.products.length);
    return controller.visit.order == null
        ? Center(
            child: Text('Không có đơn hàng'),
          )
        : Stack(children: [
            Column(
              children: [
                buildInfoSection(controller.visit.order),
                Divider(
                  thickness: 1.5,
                  color: Colors.black,
                ),
                buildHeaderListView(),
                Divider(
                  thickness: 1.5,
                  color: Colors.black,
                ),
                Expanded(
                  child: buildListView(controller.visit.order.products),
                )
              ],
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.topRight,
              child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    controller.visit.order.isExportStock == true
                        ? ('assets/images/approved.jpg')
                        : ('assets/images/pending.jpg'),
                    height: 150,
                    width: 150,
                  )),
            )),
          ]);
  }

  buildInfoSection(Order data) {
    var _iconSize = 30.0;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.timer,
                  size: _iconSize,
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
                  size: _iconSize,
                ),
              ),
              Container(
                child: Text(data.exportStockId == kDefaultGuildId
                    ? 'Chưa có kho xuất'
                    : data.exportStockName),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildHeaderListView() {
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

  buildListView(List<Product> data) {
    var formatter = new NumberFormat("#,###");
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index < data.length) {
            return buildRowListView(data[index], index);
          } else {
            double sum = 0.0;
            data.forEach((e) => sum += (e.qtyOrder * e.priceImported));
            return Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Tổng : " + formatter.format(sum) + " đ",
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
            return Divider(
              thickness: 1.5,
              color: Colors.black,
            );
          }
        },
        itemCount: data.length + 1);
  }

  Widget buildRowListView(Product item, int index) {
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
                kNumberFormat.format(item.qtyOrder),
                style: kStyleListViewItem,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
              width: 70,
              child: Container(
                  child: Text(
                kNumberFormat.format(item.priceImported),
                style: kStyleListViewItem,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
              width: 100,
              child: Container(
                  child: Text(
                kNumberFormat.format((item.priceImported * item.qtyOrder)),
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
}

// import 'dart:math';

// import 'package:dms_admin/Data/api_helper.dart';
// import 'package:dms_admin/Helper/UI.dart';
// import 'package:dms_admin/Models/order.dart';
// import 'package:dms_admin/Models/product.dart';
// import 'package:dms_admin/Pages/Stock/stock_search_page.dart';
// import 'package:dms_admin/components/loading.dart';
// import 'package:dms_admin/utils/constants.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:keyboard_dismisser/keyboard_dismisser.dart';

// class VisitOrderDetail extends StatefulWidget {
//   final String order_id;
//   VisitOrderDetail({Key key, this.order_id}) : super(key: key);

//   @override
//   _VisitOrderDetailState createState() => _VisitOrderDetailState();
// }

// class _VisitOrderDetailState extends State<VisitOrderDetail> {
//   Future<Order> f_data;
//   final formatter = new NumberFormat("#,###");
//   final TextStyle _style_header = TextStyle(
//       color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);
//   final TextStyle _style_item = TextStyle(fontSize: 14.0);
//   final icon_size = 30.0;
//   bool enabled = true;
//   Order data;
//   @override
//   void initState() {
//     super.initState();
//     print('run order : ' + widget.order_id);
//     f_data = API_HELPER.getOrder(widget.order_id);
//   }

//   Widget get _buildDivider {
//     return Divider(
//       thickness: 1.5,
//       color: Colors.black,
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
//                   size: icon_size,
//                 ),
//               ),
//               Container(
//                 child: Text(data.storeName),
//               ),
//               Container(
//                 child: Icon(
//                   Icons.phone,
//                   size: icon_size,
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
//                   size: icon_size,
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
//                   size: icon_size,
//                 ),
//               ),
//               Container(
//                 child: Text(data.createdByName),
//               ),
//               Container(
//                 child: Icon(
//                   Icons.timer,
//                   size: icon_size,
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
//                   size: icon_size,
//                 ),
//               ),
//               Container(
//                 child: Text(data.exportStockId == kDefaultGuildId
//                     ? 'Chưa có kho xuất'
//                     : data.exportStockName),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Order>(
//       future: f_data,
//       builder: (context, snapshot) {
//         if (snapshot.hasData == true) {
//           data = snapshot.data;
//           return Stack(children: [
//             Column(
//               children: [
//                 _buildInfoSection(data),
//                 _buildDivider,
//                 _buildHeaderListView,
//                 _buildDivider,
//                 Expanded(child: _buildListView(data.products))
//               ],
//             ),
//             Positioned.fill(
//                 child: Align(
//               alignment: Alignment.topRight,
//               child: Opacity(
//                   opacity: 0.5,
//                   child: Image.asset(
//                     data.isExportStock == true
//                         ? ('assets/images/approved.jpg')
//                         : ('assets/images/pending.jpg'),
//                     height: 150,
//                     width: 150,
//                   )),
//             )),
//           ]);
//         } else if (snapshot.hasError == true) {
//           return Center(child: Text("${snapshot.error}"));
//         } else {
//           return LoadingControl();
//         }
//       },
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
//                 style: _style_header,
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
//                   style: _style_header,
//                 )),
//           ),
//           Expanded(
//             child: Container(
//               child: Text(
//                 item.name,
//                 style: _style_item,
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ),
//           SizedBox(
//               width: 40,
//               child: Container(
//                   child: Text(
//                 formatter.format(item.qty),
//                 style: _style_item,
//                 textAlign: TextAlign.center,
//               ))),
//           SizedBox(
//               width: 70,
//               child: Container(
//                   child: Text(
//                 formatter.format(item.price),
//                 style: _style_item,
//                 textAlign: TextAlign.right,
//               ))),
//           SizedBox(
//               width: 100,
//               child: Container(
//                   child: Text(
//                 formatter.format((item.price * item.qty)),
//                 style: _style_item,
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
//         .postDuyetXuatDonHang(widget.order_id, data.exportStockId, 1)
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
