import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/components/error.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class StockDecreaseExportForOrderPage extends StatefulWidget {
  final String orderId;
  final String stockId;
  StockDecreaseExportForOrderPage({Key key, this.orderId, this.stockId})
      : super(key: key);

  @override
  _StockDecreaseExportForOrderPageState createState() =>
      _StockDecreaseExportForOrderPageState();
}

class _StockDecreaseExportForOrderPageState
    extends State<StockDecreaseExportForOrderPage> {
  Future<Order> fData;
  final formatter = new NumberFormat("#,###");
  final TextStyle styleHeader = TextStyle(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);
  final TextStyle styleItem = TextStyle(fontSize: 14.0);
  final iconSize = 30.0;
  bool enabled = true;
  Order data;
  @override
  void initState() {
    super.initState();
    fData = API_HELPER.getOrder(widget.orderId);
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
                  size: iconSize,
                ),
              ),
              Container(
                child: Text(data.storeName),
              ),
              Container(
                child: Icon(
                  Icons.phone,
                  size: iconSize,
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
                  size: iconSize,
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
                  size: iconSize,
                ),
              ),
              Container(
                child: Text(data.createdByName),
              ),
              Container(
                child: Icon(
                  Icons.timer,
                  size: iconSize,
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
                  size: iconSize,
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
          future: fData,
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
            data.forEach((e) => sum += (e.orderQty * e.orderPrice));
            return Expanded(
                child: Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Tổng : " + formatter.format(sum) + " đ",
                textAlign: TextAlign.end,
                style: styleHeader,
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
                style: styleHeader,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: 40,
              child: Container(
                  child: Text(
                "SL",
                style: styleHeader,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
              width: 70,
              child: Container(
                  child: Text(
                "Đơn giá",
                style: styleHeader,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
              width: 100,
              child: Container(
                  child: Text(
                "Thành tiền",
                style: styleHeader,
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
                  style: styleHeader,
                )),
          ),
          Expanded(
            child: Container(
              child: Text(
                item.name,
                style: styleItem,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
              width: 40,
              child: Container(
                  child: Text(
                formatter.format(item.orderQty),
                style: styleItem,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
              width: 70,
              child: Container(
                  child: Text(
                formatter.format(item.orderPrice),
                style: styleItem,
                textAlign: TextAlign.right,
              ))),
          SizedBox(
              width: 100,
              child: Container(
                  child: Text(
                formatter.format((item.orderPrice * item.orderQty)),
                style: styleItem,
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
      UI.showError("Chưa chọn kho xuất");
      return;
    }

    enabled = !enabled;

    API_HELPER
        .postDuyetXuatDonHang(widget.orderId, kDefaultGuildId, 2)
        .then((value) {
      if (value.isEmpty) {
        UI.showSuccess("Đã cập nhật thành công");
        Navigator.pop(context);
      } else {
        UI.showError(value);
        enabled = !enabled;
      }
    });
  }
}
