import 'package:flutter/cupertino.dart';

class Product {
  bool checked;
  int id;
  String no;
  String name;
  String unit;
  String description;
  int priceImported;
  int priceSell;
  bool isActive;
  int qtyOrder;
  int qtyImported;
  int qtyRemaining;
  int qtyCurrentStock;
  int qtyAfterImport;
  String imagePath;
  int totalImported;

  TextEditingController qtyTextEditingController =
      new TextEditingController(text: '1');
  TextEditingController priceTextEditingController =
      new TextEditingController(text: '0');

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
    priceImported = json['price_imported'];
    priceSell = json['price_sell'];
    isActive = json['is_active'];
    qtyOrder = json['qty_order'];
    qtyImported = json['qty_imported'];
    qtyRemaining = json['qty_remaining'];
    qtyCurrentStock = json['qty_current_stock'];
    qtyAfterImport = qtyRemaining + qtyCurrentStock;
    imagePath = json['image_path'];
    qtyImportedTextEditingController.text = qtyImported.toString();
    qtyImportedTextEditingController.addListener(() {
      print('value change ' + qtyImportedTextEditingController.text);
      qtyImported = int.parse(qtyImportedTextEditingController.text);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no'] = this.no;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['price_imported'] = this.priceImported;
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
