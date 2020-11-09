import 'package:dms_admin/data/model/product.dart';

class PhieuXuatDetail {
  String id;
  int seq;
  String seqNo;
  String exportStockId;
  String exportStockName;
  String importStockId;
  String importStockName;
  int status;
  String statusName;
  List<Product> products;

  PhieuXuatDetail(
      {this.id,
      this.seq,
      this.seqNo,
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
    seqNo = json['seq_no'];
    importStockId = json['import_stock_id'];
    importStockName = json['import_stock_name'];
    exportStockId = json['export_stock_id'];
    exportStockName = json['export_stock_name'];
    status = json['status'];
    statusName = json['status_name'];
    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seq'] = this.seq;
    data['seq_no'] = this.seqNo;
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
