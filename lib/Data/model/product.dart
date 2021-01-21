import 'package:dms_admin/global_widgets/price_editing_controller.dart';
import 'package:flutter/material.dart';

class Product {
  bool checked;
  int id;
  String no;
  String name;
  String unit;
  String description;
  int priceOrder;
  int priceSell;
  bool isActive;
  int qtyOrder;
  int qtyImported;
  int qtyRemaining;
  int qtyCurrentStock;
  int qtyAfterImport;
  String imagePath;
  int totalPriceAvg;
  String stockId;
  String stockName;
  TextEditingController qtyTextEditingController =
      new TextEditingController(text: '1');
  PriceEditingController priceOrderEditingController =
      new PriceEditingController('0');

  TextEditingController qtyImportedTextEditingController =
      new TextEditingController();

  Product(
      {checked,
      id,
      no,
      name,
      unit,
      description,
      priceSell,
      priceImported,
      isActive,
      qtyOrder,
      qtyImported,
      qtyRemaining,
      currentStock,
      imagePath,
      total});

  Product.fromJson(Map<String, dynamic> json) {
    // print(json['id'].toString());
    checked = false;
    id = json['id'];
    no = json['no'];
    name = json['name'];
    unit = json['unit'];
    description = json['description'];
    priceOrder = json['price_order'];
    priceSell = json['price_sell'];
    isActive = json['is_active'];
    qtyOrder = json['qty_order'];
    qtyImported = json['qty_imported'];
    qtyRemaining = json['qty_remaining'];
    qtyCurrentStock = json['qty_current_stock'];
    totalPriceAvg = json['total_price_avg'];
    qtyAfterImport = qtyRemaining + qtyCurrentStock;
    imagePath = json['image_path'];
    stockId = json['stock_id'];
    stockName = json['stock_name'];
    qtyImportedTextEditingController.text = qtyImported.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no'] = this.no;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['price_order'] = this.priceOrder;
    data['price_sell'] = this.priceSell;
    data['is_active'] = this.isActive;
    data['qty_order'] = this.qtyOrder;
    data['qty_imported'] = this.qtyImported;
    data['qty_remaining'] = this.qtyRemaining;
    data['qty_current_stock'] = this.qtyCurrentStock;
    data['image_path'] = this.imagePath;

    return data;
  }
}
