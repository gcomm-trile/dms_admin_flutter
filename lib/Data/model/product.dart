import 'package:get/get.dart';

class RxProductModel {
  Rx<bool> checked;
  Rx<int> id;
  Rx<String> no;
  Rx<String> name;
  Rx<String> unit;
  Rx<String> description;
  Rx<int> price;
  Rx<bool> isActive;
  Rx<int> qty;
  Rx<String> imagePath;
  Rx<int> total;
}

class Product {
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
  final rx = RxProductModel();

  get checked => rx.checked.value;
  set checked(value) => rx.checked.value = value;

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  get no => rx.no.value;
  set no(value) => rx.no.value = value;

  get name => rx.name.value;
  set name(value) => rx.name.value = value;

  get unit => rx.unit.value;
  set unit(value) => rx.unit.value = value;

  get description => rx.description.value;
  set description(value) => rx.description.value = value;

  get price => rx.price.value;
  set price(value) => rx.price.value = value;

  get isActive => rx.isActive.value;
  set isActive(value) => rx.isActive.value = value;

  get qty => rx.qty.value;
  set qty(value) => rx.qty.value = value;

  get imagePath => rx.imagePath.value;
  set imagePath(value) => rx.imagePath.value = value;

  get total => rx.total.value;
  set total(value) => rx.total.value = value;

  Product.fromJson(Map<String, dynamic> json) {
    checked.value = false;
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
