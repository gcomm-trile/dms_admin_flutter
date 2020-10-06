class PhieuXuatDetail {
  String id;
  String seq;
  String exportStockId;
  String exportStockName;
  String importStockId;
  String importStockName;
  int status;
  String statusName;
  List<PhieuXuatDetailProduct> products;

  PhieuXuatDetail(
      {this.id,
      this.seq,
      this.importStockId,
      this.importStockName,
      this.exportStockId,
      this.exportStockName,
      this.status,
      this.statusName,
      this.products});

  PhieuXuatDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seq = json['seq'];
    importStockId = json['import_stock_id'];
    importStockName = json['import_stock_name'];
    exportStockId = json['export_stock_id'];
    exportStockName = json['export_stock_name'];
    status = json['status'];
    statusName = json['status_name'];
    if (json['products'] != null) {
      products = new List<PhieuXuatDetailProduct>();
      json['products'].forEach((v) {
        products.add(new PhieuXuatDetailProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['import_stock_id'] = this.importStockId;
    data['import_stock_name'] = this.importStockName;
    data['export_stock_id'] = this.exportStockId;
    data['export_stock_name'] = this.exportStockName;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhieuXuatDetailProduct {
  int productId;
  int qty;
  String productNo;
  String productName;
  int productPrice;

  PhieuXuatDetailProduct(
      {this.productId,
      this.qty,
      this.productNo,
      this.productName,
      this.productPrice});

  PhieuXuatDetailProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
    productNo = json['product_no'];
    productName = json['product_name'];
    productPrice = json['product_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['product_no'] = this.productNo;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    return data;
  }
}
