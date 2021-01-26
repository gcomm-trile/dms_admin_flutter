import 'package:dms_admin/global_widgets/price_editing_controller.dart';
import 'package:flutter/material.dart';

class Product {
  bool checked;
  int id;
  String no;
  String name;
  String unit;
  String description;
  int orderPrice;
  int sellPrice;
  bool isActive;
  int orderQty;

  int remainingQty;

  int inQty;
  int outQty;
  int inStockQty;
  int outStockQty;
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
    orderPrice = json['order_price'];
    sellPrice = json['sell_price'];
    isActive = json['is_active'];
    orderQty = json['order_qty'];
    remainingQty = json['remaining_qty'];
    totalPriceAvg = json['total_price_avg'];
    imagePath = json['image_path'];
    stockId = json['stock_id'];
    stockName = json['stock_name'];
    inQty = json['in_qty'];
    outQty = json['out_qty'];
    inStockQty = json['in_stock_qty'];
    outStockQty = json['out_stock_qty'];
    qtyImportedTextEditingController.text = inQty.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_price'] = this.orderPrice;
    data['in_qty'] = this.inQty;
    data['out_qty'] = this.outQty;
    data['order_qty'] = this.orderQty;
    return data;
  }
}
