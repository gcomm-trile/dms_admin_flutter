import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_nhap_detail.dart';
import 'package:dms_admin/Pages/Product/product_search_page.dart';
import 'package:dms_admin/components/qty_textfield.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';

class StockIncreaseImportPage extends StatefulWidget {
  final String phieuNhapId;
  final String stockId;
  StockIncreaseImportPage({Key key, this.phieuNhapId, this.stockId})
      : super(key: key);

  @override
  _StockIncreaseImportPageState createState() =>
      _StockIncreaseImportPageState();
}

class _StockIncreaseImportPageState extends State<StockIncreaseImportPage> {
  Future<List<PhieuNhapDetail>> phieuNhapDetails;
  List<PhieuNhapDetail> products;
  @override
  void initState() {
    super.initState();
    phieuNhapDetails = API_HELPER.listPhieuNhapDetail(widget.phieuNhapId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbarSection(context), body: _buildBodySection(context));
  }

  void _showPopupProduct(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: ProductSearchPage(
              stock_id: widget.stockId,
              savedData: (selectedProducts) {
                setState(() {
                  log("Đã chọn ${selectedProducts.length.toString()}");
                  log("Đang có ${products.length.toString()}");
                  for (var selectedProduct in selectedProducts) {
                    print("check ${selectedProduct.productId}");
                    if (products
                            .where((element) =>
                                element.productId == selectedProduct.productId)
                            .length ==
                        0) {
                      log("Đã chọn ${selectedProduct.productId.toString()}");
                      log("Đã chọn ${selectedProduct.productName.toString()}");
                      products.add(new PhieuNhapDetail(
                          productId: selectedProduct.productId,
                          productNo: selectedProduct.productNo,
                          productName: selectedProduct.productName,
                          productPrice: selectedProduct.productPrice,
                          qty: 0));
                    }
                  }
                });
              },
            ),
          );
        });
  }

  Widget _buildAppbarSection(BuildContext context) {
    return AppBar(
      title: Text("Nhập trực tiếp"),
      actions: [
        InkWell(
            child: Container(width: 50, child: Icon(Icons.done)),
            onTap: () {
              API_HELPER
                  .postPhieuNhapDetail(
                      widget.stockId,
                      '00000000-0000-0000-0000-000000000000',
                      widget.phieuNhapId,
                      '00000000-0000-0000-0000-000000000000',
                      products.where((element) => element.qty > 0).toList())
                  .then((value) {
                if (value.isEmpty) {
                  UI.showSuccess(context, "Đã cập nhật thành công");
                  Navigator.pop(context);
                } else {
                  UI.showError(context, value);
                }
              });
            }),
      ],
    );
  }

  Widget get _buildListViewHeaderSection {
    return ListTile(
      title: Row(children: <Widget>[
        SizedBox(
          child: Text(
            "",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          width: 40,
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          child: Text(
            "Mã",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          width: 80,
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text("Tên",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          width: widthQuantibox,
          child: Text("SL",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }

  final double widthQuantibox = 80.0;
  Widget get _buildAddProductSection {
    return Positioned(
        right: 20,
        bottom: 20,
        height: 50,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            log("Thêm sản phẩm mới");
            _showPopupProduct(context);
          },
        ));
  }

  void _removeProduct(PhieuNhapDetail product) {
    setState(() {
      products.remove(product);
    });
  }

  Widget _buildListViewRowSection(PhieuNhapDetail product) {
    return ListTile(
        title: Row(children: <Widget>[
      InkWell(
        child: Container(
          width: 20,
          padding: EdgeInsets.only(left: 2.0),
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        onTap: () => _removeProduct(product),
      ),
      SizedBox(
        width: 10,
      ),
      SizedBox(
        child: Container(child: Text(product.productNo)),
        width: kWidthProductNo,
      ),
      SizedBox(
        width: 2,
      ),
      Expanded(
        child: Container(child: Text(product.productName)),
      ),
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: QtyTextField(
          value: product.qty,
          minValue: 0,
          maxValue: 9999,
          onChangedValue: (value) {
            product.qty = value;
          },
        ),
      )
    ]));
  }

  _buildBodySection(BuildContext context) {
    return FutureBuilder<List<PhieuNhapDetail>>(
      future: phieuNhapDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          products = snapshot.data;
          return Stack(
            children: [
              products.length == 0
                  ? Center(
                      child: Text(
                          "Không có sản phẩm.Vui lòng bấm dấu + để thêm sản phẩm mới"),
                    )
                  : Column(children: [
                      Divider(
                        color: Colors.black,
                        thickness: 0.2,
                      ),
                      // _buildListViewHeaderSection,
                      Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.black,
                                  thickness: 0.2,
                                );
                              },
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return _buildListViewRowSection(
                                    products[index]);
                              },
                              itemCount: products.length))
                    ]),
              _buildAddProductSection
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
