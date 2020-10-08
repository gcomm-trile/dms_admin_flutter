import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_xuat_detail.dart';
import 'package:dms_admin/Pages/Product/product_search_page.dart';
import 'package:dms_admin/Pages/Stock/stock_search_page.dart';
import 'package:dms_admin/components/error.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/components/qty_textfield.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';

class StockDecreaseExportPage extends StatefulWidget {
  final String phieuXuatId;
  final String stockId;
  StockDecreaseExportPage({Key key, this.phieuXuatId, this.stockId})
      : super(key: key);

  @override
  _StockDecreaseExportPageState createState() =>
      _StockDecreaseExportPageState();
}

class _StockDecreaseExportPageState extends State<StockDecreaseExportPage> {
  final double widthQuantibox = 80.0;
  Future<PhieuXuatDetail> f_phieuXuatDetail;
  PhieuXuatDetail phieuXuatDetail;
  @override
  void initState() {
    super.initState();
    f_phieuXuatDetail = API_HELPER.listPhieuXuatDetail(widget.phieuXuatId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbarSection(context), body: _buildBodySection(context));
  }

  Widget _buildAppbarSection(BuildContext context) {
    return AppBar(
      title: Text("Chi tiết phiếu xuất"),
      actions: [
        InkWell(
          onTap: () {
            API_HELPER
                .postPhieuXuatDetail(
                    phieuXuatDetail.importStockId,
                    widget.stockId,
                    '00000000-0000-0000-0000-000000000000',
                    widget.phieuXuatId,
                    phieuXuatDetail.products
                        .where((element) => element.qty > 0)
                        .toList())
                .then((value) {
              if (value.isEmpty) {
                UI.showSuccess(context, "Đã cập nhật thành công");
                Navigator.pop(context);
              } else {
                UI.showError(context, value);
              }
            });
          },
          child: Container(
            width: 50.0,
            child: Icon(
              Icons.approval,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodySection(BuildContext context) {
    return FutureBuilder<PhieuXuatDetail>(
      future: f_phieuXuatDetail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          phieuXuatDetail = snapshot.data;
          return Column(children: [
            _buildImportStockSection(context, snapshot.data),
            Divider(
              thickness: 1.5,
              color: Colors.black,
            ),
            Expanded(child: _buildListViewSection(snapshot.data.products))
          ]);
        } else if (snapshot.hasError) {
          return ErrorControl(
            error: snapshot.error,
          );
        }
        return LoadingControl();
      },
    );
  }

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

  Widget _buildRowListViewSection(PhieuXuatDetailProduct product) {
    return Container(
        child: Row(children: <Widget>[
      InkWell(
        onTap: () => _removeProduct(product),
        child: Container(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.close,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
      SizedBox(
        width: 5.0,
      ),
      SizedBox(
        child: Text(product.productNo),
        width: kWidthProductNo,
      ),
      Expanded(
        child: Text(product.productName),
      ),
      Container(
        width: 110,
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

  Widget _buildListViewSection(List<PhieuXuatDetailProduct> products) {
    return Stack(
      children: [
        products.length == 0
            ? Center(
                child: Text(kEmptyProductList),
              )
            : Column(children: [
                // _buildListViewHeaderSection,
                Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 0.4,
                            color: kPrimaryColor,
                          );
                        },
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildRowListViewSection(products[index]);
                        },
                        itemCount: products.length))
              ]),
        _buildAddProductSection
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
          InkWell(
            onTap: () => _showPopupSearchStock(context),
            child: Container(
              child: Icon(
                Icons.search,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removeProduct(PhieuXuatDetailProduct product) {
    setState(() {
      phieuXuatDetail.products.remove(product);
    });
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
                  for (var selectedProduct in selectedProducts) {
                    if (phieuXuatDetail.products
                            .where((element) =>
                                element.productId == selectedProduct.productId)
                            .length ==
                        0) {
                      log("Đã chọn ${selectedProduct.productId.toString()}");
                      log("Đã chọn ${selectedProduct.productName.toString()}");
                      phieuXuatDetail.products.add(new PhieuXuatDetailProduct(
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

  void _showPopupSearchStock(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: StockSearchPage(
              savedData: (selectedStock) {
                setState(() {
                  phieuXuatDetail.importStockId = selectedStock.id;
                  phieuXuatDetail.importStockName = selectedStock.name;
                });
              },
            ),
          );
        });
  }
}
