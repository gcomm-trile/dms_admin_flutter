import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_nhap_detail.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Pages/Product/product_search_page.dart';
import 'package:dms_admin/components/qty_textfield.dart';
import 'package:flutter/material.dart';

class StockRequestImportPage extends StatefulWidget {
  final String phieuNhapId;
  StockRequestImportPage({Key key, this.phieuNhapId}) : super(key: key);

  @override
  _StockRequestImportPageState createState() => _StockRequestImportPageState();
}

class _StockRequestImportPageState extends State<StockRequestImportPage> {
  Future<List<PhieuNhapDetail>> phieuNhapDetails;
  List<PhieuNhapDetail> products;
  @override
  void initState() {
    super.initState();
    phieuNhapDetails = API_HELPER.fetchPhieuNhapDetail(widget.phieuNhapId);
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
              savedData: (selectedProducts) {
                setState(() {
                  log("Đã chọn ${selectedProducts.length.toString()}");
                  for (var selectedProduct in selectedProducts) {
                    if (products
                            .where((element) =>
                                element.productId == selectedProduct.id)
                            .length ==
                        0) {
                      log("Đã chọn ${selectedProduct.id.toString()}");
                      log("Đã chọn ${selectedProduct.name.toString()}");
                      products.add(new PhieuNhapDetail(
                          productId: selectedProduct.id,
                          productNo: selectedProduct.no,
                          productName: selectedProduct.name,
                          productPrice: selectedProduct.price,
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
      title: Text("Chi tiết phiếu nhập"),
      actions: [
        RaisedButton(
          color: Colors.transparent,
          onPressed: () {
            UI.showSuccess(context, "Đã cập nhật thành công");
            Navigator.pop(context);
          },
          child: Icon(
            Icons.done,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget get _buildListViewHeaderSection {
    return ListTile(
      title: Row(children: <Widget>[
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

  Widget _buildListViewRowSection(PhieuNhapDetail product) {
    return ListTile(
      title: Row(children: <Widget>[
        SizedBox(
          child: Text(product.productNo),
          width: 80,
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text(product.productName),
        ),
        QtyTextField(value: product.qty, minValue: 0, maxValue: 10)
      ]),
    );
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
                      child: Text("No data"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildListViewHeaderSection;
                        } else
                          return _buildListViewRowSection(products[index - 1]);
                      },
                      itemCount: products.length + 1),
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
