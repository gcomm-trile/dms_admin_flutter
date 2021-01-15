import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_xuat_detail.dart';
import 'package:dms_admin/components/header_listview_product.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class StockIncreaseApprovePage extends StatefulWidget {
  final String phieuXuatId;
  final String stockId;
  StockIncreaseApprovePage({Key key, this.phieuXuatId, this.stockId})
      : super(key: key);

  @override
  _StockIncreaseApprovePageState createState() =>
      _StockIncreaseApprovePageState();
}

class _StockIncreaseApprovePageState extends State<StockIncreaseApprovePage> {
  final double widthQuantibox = 80.0;
  Future<PhieuXuatDetail> fPhieuXuatDetail;
  PhieuXuatDetail phieuXuatDetail;
  final TextStyle styleItem = TextStyle(fontSize: 14.0);
  @override
  void initState() {
    super.initState();
    fPhieuXuatDetail = API_HELPER.getPhieuXuatDetail(widget.phieuXuatId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbarSection(context), body: _buildBodySection(context));
  }

  Widget _buildAppbarSection(BuildContext context) {
    return AppBar(title: Text("Nhận phiếu xuất"));
  }

  Widget _buildListViewRowSection(Product product, int index) {
    return Container(
        child: Row(children: <Widget>[
      SizedBox(
        child: Text(
          '${(index + 1).toString()}.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        width: 30,
      ),
      Expanded(
        child: Text(
          product.name,
          style: styleItem,
        ),
      ),
      SizedBox(
          width: 80.0,
          child: Container(
              child: Text(
            product.qtyOrder.toString(),
            textAlign: TextAlign.center,
            style: styleItem,
          ))),
      SizedBox(
        width: 5.0,
      ),
    ]));
  }

  Widget _buildItemsSection(List<Product> products, int status) {
    return Stack(
      children: [
        products.length == 0
            ? Center(
                child: Text(kEmptyProductList),
              )
            : Stack(
                children: [
                  Column(children: [
                    HeaderListViewProduct(
                      sizedQty: 80,
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.black,
                    ),
                    Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              );
                            },
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _buildListViewRowSection(
                                  products[index], index);
                            },
                            itemCount: products.length))
                  ]),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          (status == 2
                              ? 'assets/images/approved.jpg'
                              : (status == 3
                                  ? 'assets/images/cancelled.jpg'
                                  : 'assets/images/pending.jpg')),
                          height: 200,
                          width: 200,
                        )),
                  ))
                ],
              ),
      ],
    );
  }

  Widget _buildImportStockSection(
      BuildContext context, PhieuXuatDetail phieuXuatDetail) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(
            "Kho nhận:",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
              (phieuXuatDetail.importStockName == null)
                  ? "Chưa có kho nhận"
                  : phieuXuatDetail.importStockName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }

  _buildBodySection(BuildContext context) {
    return FutureBuilder<PhieuXuatDetail>(
      future: fPhieuXuatDetail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          phieuXuatDetail = snapshot.data;
          return Column(children: [
            _buildImportStockSection(context, snapshot.data),
            Divider(
              thickness: 1.5,
              color: Colors.black,
            ),
            Expanded(
                child: _buildItemsSection(
                    snapshot.data.products, snapshot.data.status)),
            Container(
              padding: EdgeInsets.all(5.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 10.0,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RaisedButton.icon(
                        color: Colors.green,
                        onPressed: () => _approved(2),
                        icon: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        label: Text("Đồng ý",
                            style: TextStyle(color: Colors.white))),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RaisedButton.icon(
                        color: Colors.red,
                        onPressed: () => _approved(3),
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        label: Text("Từ chối",
                            style: TextStyle(color: Colors.white))),
                  ),
                ],
              ),
            )
          ]);
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _approved(int status) {
    API_HELPER.postDuyetPhieuXuat(widget.phieuXuatId, status).then((value) {
      if (value.isEmpty) {
        UI.showSuccess("Đã cập nhật thành công");
        Navigator.pop(context);
      } else {
        UI.showError(value);
      }
    });
  }
}
