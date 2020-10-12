import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/order.dart';
import 'package:dms_admin/Models/phieu_xuat_detail.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Pages/Product/product_search_page.dart';
import 'package:dms_admin/Pages/Stock/stock_search_page.dart';
import 'package:dms_admin/components/error.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/components/qty_textfield.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class StockDecreaseExportForOrderPage extends StatefulWidget {
  final String order_id;
  final String stockId;
  StockDecreaseExportForOrderPage({Key key, this.order_id, this.stockId})
      : super(key: key);

  @override
  _StockDecreaseExportForOrderPageState createState() =>
      _StockDecreaseExportForOrderPageState();
}

class _StockDecreaseExportForOrderPageState
    extends State<StockDecreaseExportForOrderPage> {
  Future<Order> f_data;
  final formatter = new NumberFormat("#,###");
  final TextStyle _style_header = TextStyle(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);
  final TextStyle _style_item = TextStyle(fontSize: 14.0);
  final icon_size = 30.0;
  bool enabled = true;
  Order data;
  @override
  void initState() {
    super.initState();
    f_data = API_HELPER.getOrder(widget.order_id);
  }

  Widget get _buildDivider {
    return Divider(
      thickness: 1.5,
      color: Colors.black,
    );
  }

  Widget _buildInfoSection(Order data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.store,
                  size: icon_size,
                ),
              ),
              Container(
                child: Text(data.storeName),
              ),
              Container(
                child: Icon(
                  Icons.phone,
                  size: icon_size,
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
                  size: icon_size,
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
                  size: icon_size,
                ),
              ),
              Container(
                child: Text(data.createdByName),
              ),
              Container(
                child: Icon(
                  Icons.timer,
                  size: icon_size,
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
                  size: icon_size,
                ),
              ),
              Container(
                child: Text(data.exportStockName == null
                    ? "N/A"
                    : data.exportStockName),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết đơn hàng'),
          actions: [
            AbsorbPointer(
              absorbing: !enabled,
              child: InkWell(
                  onTap: () => _cancel(),
                  child: Container(
                      child: Icon(Icons.cancel, color: Colors.red, size: 50))),
            )
          ],
        ),
        body: FutureBuilder<Order>(
          future: f_data,
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              data = snapshot.data;
              return Stack(children: [
                Column(
                  children: [
                    _buildInfoSection(data),
                    _buildDivider,
                    _buildHeaderListView,
                    _buildDivider,
                    Expanded(child: _buildListView(data.products))
                  ],
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.topRight,
                  child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/images/approved.jpg',
                        height: 150,
                        width: 150,
                      )),
                )),
              ]);
            } else if (snapshot.hasError == true) {
              return ErrorControl(
                error: snapshot.error,
              );
            } else {
              return LoadingControl();
            }
          },
        ),
      ),
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
            data.forEach((e) => sum += (e.qty * e.price));
            return Expanded(
                child: Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Tổng : " + formatter.format(sum) + " đ",
                textAlign: TextAlign.end,
                style: _style_header,
              ),
            ));
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
                style: _style_header,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: 40,
              child: Container(
                  child: Text(
                "SL",
                style: _style_header,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
              width: 70,
              child: Container(
                  child: Text(
                "Đơn giá",
                style: _style_header,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
              width: 100,
              child: Container(
                  child: Text(
                "Thành tiền",
                style: _style_header,
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
                  style: _style_header,
                )),
          ),
          Expanded(
            child: Container(
              child: Text(
                item.name,
                style: _style_item,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: 40,
              child: Container(
                  child: Text(
                formatter.format(item.qty),
                style: _style_item,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
              width: 70,
              child: Container(
                  child: Text(
                formatter.format(item.price),
                style: _style_item,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
              width: 100,
              child: Container(
                  child: Text(
                formatter.format((item.price * item.qty)),
                style: _style_item,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }

  _cancel() {
    if (data.exportStockId == kDefaultGuildId) {
      UI.showError(context, "Chưa chọn kho xuất");
      return;
    }

    enabled = !enabled;

    API_HELPER
        .postDuyetXuatDonHang(widget.order_id, kDefaultGuildId, 2)
        .then((value) {
      if (value.isEmpty) {
        UI.showSuccess(context, "Đã cập nhật thành công");
        Navigator.pop(context);
      } else {
        UI.showError(context, value);
        enabled = !enabled;
      }
    });
  }
}