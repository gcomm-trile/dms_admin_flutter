import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RxProductModel {
  RxBool checked = false.obs;
  RxInt id = 0.obs;
  RxString no = ''.obs;
  RxString name = ''.obs;
  RxString unit = ''.obs;
  RxString description = ''.obs;
  RxInt price = 0.obs;
  RxBool isActive = false.obs;
  RxInt qty = 0.obs;
  RxString imagePath = ''.obs;
  RxInt total = 0.obs;
}

class Product {
  bool checked;
  int id;
  String no;
  String name;
  String unit;
  String description;
  int price;
  bool isActive;
  int qty;
  String imagePath;
  int total;

  TextEditingController controller = new TextEditingController(text: '1');
  Product(
      {checked,
      id,
      no,
      name,
      unit,
      description,
      price,
      isActive,
      qty,
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
    price = json['price'];
    isActive = json['is_active'];
    qty = json['qty'];
    imagePath = json['image_path'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no'] = this.no;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_active'] = this.isActive;
    data['qty'] = this.qty;
    data['image_path'] = this.imagePath;
    data['total'] = this.total;
    return data;
  }
}

// class Product {
//   Rx<bool> checked;
//   int id;
//   String no;
//   String name;
//   String unit;
//   String description;
//   int price;
//   bool isActive;
//   int qty;
//   String imagePath;
//   int total;

//   Product(
//       {this.checked,
//       this.id,
//       this.no,
//       this.name,
//       this.unit,
//       this.description,
//       this.price,
//       this.isActive,
//       this.qty,
//       this.imagePath,
//       this.total});

//   Product.fromJson(Map<String, dynamic> json) {
//     checked.value = false;
//     id = json['id'];
//     no = json['no'];
//     name = json['name'];
//     unit = json['unit'];
//     description = json['description'];
//     price = json['price'];
//     isActive = json['is_active'];
//     qty = json['qty'];
//     imagePath = json['image_path'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['no'] = this.no;
//     data['name'] = this.name;
//     data['unit'] = this.unit;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['is_active'] = this.isActive;
//     data['qty'] = this.qty;
//     data['image_path'] = this.imagePath;
//     data['total'] = this.total;
//     return data;
//   }
// }
