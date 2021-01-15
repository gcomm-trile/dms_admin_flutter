import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/phieu_nhap_detail.dart';
import 'package:dms_admin/modules/product/product_search_page.dart';
import 'package:dms_admin/modules/stock/stock_search_page.dart';
import 'package:dms_admin/components/error.dart';
import 'package:dms_admin/components/header_listview_product.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/components/qty_textfield.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class StockIncreaseImportPage extends StatefulWidget {
  final String phieuNhapId;

  StockIncreaseImportPage({Key key, this.phieuNhapId}) : super(key: key);

  @override
  _StockIncreaseImportPageState createState() =>
      _StockIncreaseImportPageState();
}

class _StockIncreaseImportPageState extends State<StockIncreaseImportPage> {
  Future<PhieuNhapDetail> phieuNhapDetail;
  PhieuNhapDetail data;

  @override
  void initState() {
    super.initState();
    phieuNhapDetail = API_HELPER.getPhieuNhapDetail(widget.phieuNhapId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbarSection(context),
      body: _buildBodySection(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showPopupProduct(context),
          child: Icon(Icons.add, size: kSizeIconAddButton)),
    );
  }

  void _showPopupProduct(BuildContext context) {
    if (data.importStockId == null || data.importStockId == kDefaultGuildId) {
      UI.showError('Chọn kho nhập trước');
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: ProductSearchPage(
              stockId: data.importStockId,
              savedData: (selectedProducts) {
                setState(() {
                  log("Đã chọn ${selectedProducts.length.toString()}");
                  log("Đang có ${data.products.length.toString()}");
                  for (var selectedProduct in selectedProducts) {
                    print("check ${selectedProduct.productId}");
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
                          priceImported: selectedProduct.productPrice,
                          qtyOrder: 0));
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
            child: Container(
                width: 50,
                child: Icon(
                  Icons.approval,
                  size: 50.0,
                )),
            onTap: () {
              API_HELPER
                  .postPhieuNhapDetail(
                      data.importStockId,
                      '00000000-0000-0000-0000-000000000000',
                      widget.phieuNhapId,
                      '00000000-0000-0000-0000-000000000000',
                      data.products
                          .where((element) => element.qtyOrder > 0)
                          .toList())
                  .then((value) {
                if (value.isEmpty) {
                  UI.showSuccess("Đã cập nhật thành công");
                  Navigator.pop(context);
                } else {
                  UI.showError(value);
                }
              });
            }),
      ],
    );
  }

  final double widthQuantibox = 80.0;

  void _removeProduct(Product product) {
    setState(() {
      data.products.remove(product);
    });
  }

  Widget _buildListViewRowSection(Product product) {
    return Row(children: <Widget>[
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
      Expanded(
        child: Container(child: Text(product.name)),
      ),
      Container(
        width: 110,
        padding: EdgeInsets.all(2.0),
        child: QtyTextField(
          value: product.qtyOrder,
          minValue: 0,
          maxValue: 9999,
          onChangedValue: (value) {
            product.qtyOrder = value;
          },
        ),
      )
    ]);
  }

  _buildInfoSection(BuildContext context, PhieuNhapDetail phieuNhapDetail) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.call_received, size: 30.0),
              SizedBox(
                width: 10.0,
              ),
              InkWell(
                  onTap: () {
                    print('open select import stock');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: StockSearchPage(
                              savedData: (selectedItem) {
                                setState(() {
                                  data.importStockId = selectedItem.id;
                                  data.importStockName = selectedItem.name;
                                });
                              },
                            ),
                          );
                        });
                  },
                  child: Expanded(
                      child: Text(
                    phieuNhapDetail.importStockName == null
                        ? "CHỌN KHO NHẬP"
                        : phieuNhapDetail.importStockName,
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  )))
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }

  _buildBodySection(BuildContext context) {
    return FutureBuilder<PhieuNhapDetail>(
      future: phieuNhapDetail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          data = snapshot.data;

          return Column(
            children: [
              _buildInfoSection(context, data),
              data.products.length == 0
                  ? Expanded(
                      child: Center(
                        child: Text(
                            "Không có sản phẩm.Vui lòng bấm dấu + để thêm sản phẩm mới"),
                      ),
                    )
                  : HeaderListViewProduct(
                      sizedQty: 110.0,
                    ),
              data.products.length == 0
                  ? SizedBox(
                      height: 0.0,
                    )
                  : Divider(thickness: 1.5, color: Colors.black),
              data.products.length == 0
                  ? SizedBox(
                      height: 0.0,
                    )
                  : Expanded(
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
                                data.products[index]);
                          },
                          itemCount: data.products.length))
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorControl(error: snapshot.error);
        }
        return LoadingControl();
      },
    );
  }
}
