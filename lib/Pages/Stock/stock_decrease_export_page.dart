import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_xuat_detail.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Pages/Product/product_search_page.dart';
import 'package:dms_admin/Pages/Stock/stock_search_page.dart';
import 'package:dms_admin/components/error.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/components/qty_textfield.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockDecreaseExportPage extends StatefulWidget {
  final String phieuXuatId;
  StockDecreaseExportPage({Key key, this.phieuXuatId}) : super(key: key);

  @override
  _StockDecreaseExportPageState createState() =>
      _StockDecreaseExportPageState();
}

class _StockDecreaseExportPageState extends State<StockDecreaseExportPage> {
  final double widthQuantibox = 80.0;
  Future<PhieuXuatDetail> f_phieuXuatDetail;
  PhieuXuatDetail data;
  final formatter = new NumberFormat("#,###");
  final TextStyle _style_header = TextStyle(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold);
  final TextStyle _style_item = TextStyle(fontSize: 14.0);
  final icon_size = 30.0;

  @override
  void initState() {
    super.initState();
    f_phieuXuatDetail = API_HELPER.getPhieuXuatDetail(widget.phieuXuatId);
  }

  Widget _buildAppbarSection(BuildContext context, int status) {
    return AppBar(
      title: Text("Chi tiết phiếu xuất"),
      actions: [
        (status != 0 && status != 1)
            ? Container(
                child: Text(''),
              )
            : InkWell(
                onTap: () {
                  API_HELPER
                      .postPhieuXuatDetail(
                          data.importStockId,
                          data.exportStockId,
                          '00000000-0000-0000-0000-000000000000',
                          widget.phieuXuatId,
                          data.products
                              .where((element) => element.qty > 0)
                              .toList())
                      .then((value) {
                    if (value.isEmpty) {
                      UI.showSuccess( "Đã cập nhật thành công");
                      Navigator.pop(context);
                    } else {
                      UI.showError( value);
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

  Widget build(BuildContext context) {
    return FutureBuilder<PhieuXuatDetail>(
      future: f_phieuXuatDetail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          data = snapshot.data;
          return Scaffold(
            appBar: _buildAppbarSection(context, data.status),
            body: Stack(children: [
              Column(children: [
                _buildInfoSection(context, snapshot.data),
                Divider(
                  thickness: 1.5,
                  color: Colors.black,
                ),
                _buildHeaderListView,
                Divider(
                  thickness: 1.5,
                  color: Colors.black,
                ),
                Expanded(child: _buildListViewSection(snapshot.data.products))
              ]),
              // Positioned(
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Opacity(
              //         opacity: 0.5,
              //         child: Image.asset(
              //           snapshot.data.status == 2
              //               ? 'assets/images/approved.jpg'
              //               : 'assets/images/pending.jpg',
              //           height: 150,
              //           width: 150,
              //         )),
              //   ),
              // ),
            ]),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: _buildAppbarSection(context, 0),
              body: ErrorControl(
                error: snapshot.error,
              ));
        }
        return Scaffold(
            appBar: _buildAppbarSection(context, 0), body: LoadingControl());
      },
    );
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
              width: 110,
              child: Container(
                  child: Text(
                "SL",
                style: _style_header,
                textAlign: TextAlign.center,
              ))),
          SizedBox(
            width: 5.0,
          ),
        ],
      ),
    );
  }

  Widget _buildRowListViewSection(Product product) {
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
      Expanded(
        child: Text(product.name),
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
      ),
      SizedBox(
        width: 5.0,
      ),
    ]));
  }

  Widget _buildListViewSection(List<Product> products) {
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

  Widget _buildInfoSection(BuildContext context, PhieuXuatDetail data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildImportStockSection(context, data)],
      ),
    );
  }

  Widget _buildImportStockSection(
      BuildContext context, PhieuXuatDetail phieuXuatDetail) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.call_received,
                  size: 50.0,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: StockSearchPage(
                            savedData: (selectedStock) {
                              setState(() {
                                data.importStockId = selectedStock.id;
                                data.importStockName = selectedStock.name;
                              });
                            },
                          ),
                        );
                      });
                },
                child: Text(
                    (phieuXuatDetail.importStockName == null)
                        ? "Chưa có kho nhận"
                        : phieuXuatDetail.importStockName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(
                  Icons.call_made,
                  size: 50.0,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: StockSearchPage(
                            savedData: (selectedStock) {
                              setState(() {
                                data.exportStockId = selectedStock.id;
                                data.exportStockName = selectedStock.name;
                              });
                            },
                          ),
                        );
                      });
                },
                child: Text(
                    (phieuXuatDetail.exportStockName == null)
                        ? "Chưa có kho xuất"
                        : phieuXuatDetail.exportStockName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ],
      ),
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

  void _removeProduct(Product product) {
    setState(() {
      data.products.remove(product);
    });
  }

  void _showPopupProduct(BuildContext context) {
    if (data.exportStockId == null || data.exportStockId == kDefaultGuildId) {
      UI.showError( 'Chưa chọn kho xuất');
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: ProductSearchPage(
              stock_id: data.exportStockId,
              savedData: (selectedProducts) {
                setState(() {
                  log("Đã chọn ${selectedProducts.length.toString()}");
                  for (var selectedProduct in selectedProducts) {
                    if (data.products
                            .where((element) =>
                                element.id == selectedProduct.productId)
                            .length ==
                        0) {
                      log("Đã chọn ${selectedProduct.productId.toString()}");
                      log("Đã chọn ${selectedProduct.productName.toString()}");
                      data.products.add(new Product(
                          id: selectedProduct.productId,
                          no: selectedProduct.productNo,
                          name: selectedProduct.productName,
                          price: selectedProduct.productPrice,
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
                  data.importStockId = selectedStock.id;
                  data.importStockName = selectedStock.name;
                });
              },
            ),
          );
        });
  }
}
