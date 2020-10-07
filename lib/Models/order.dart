import 'package:dms_admin/Models/product.dart';

class Order {
  String seq;
  String id;
  String storeId;
  String storeName;
  String storeAddress;
  String contactPerson;
  String note;
  String createdByName;
  String createdOn;
  bool isExportedStock;
  String exportedStockId;
  String exportedStockName;
  List<Product> products;

  Order(
      {this.seq,
      this.id,
      this.storeId,
      this.storeName,
      this.storeAddress,
      this.contactPerson,
      this.note,
      this.createdByName,
      this.createdOn,
      this.isExportedStock,
      this.exportedStockId,
      this.exportedStockName,
      this.products});

  Order.fromJson(Map<String, dynamic> json) {
    seq = json['seq'];
    id = json['id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    contactPerson = json['contact_person'];
    note = json['note'];
    createdByName = json['created_by_name'];
    createdOn = json['created_on'];
    isExportedStock = json['is_exported_stock'];
    exportedStockId = json['exported_stock_id'];
    exportedStockName = json['exported_stock_name'];

    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seq'] = this.seq;
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    data['contact_person'] = this.contactPerson;
    data['note'] = this.note;
    data['created_by_name'] = this.createdByName;
    data['created_on'] = this.createdOn;
    data['is_exported_stock'] = this.isExportedStock;
    data['exported_stock_id'] = this.exportedStockId;
    data['exported_stock_name'] = this.exportedStockName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
