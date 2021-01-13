import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/vendor.dart';

class PurchaseOrder {
  String purchaseOrderId;
  String importStockId;
  String importStockName;
  String seqNo;
  String vendorId;
  String vendorName;
  List<Product> products;
  List<Vendor> vendors;
  List<Stock> stocks;

  PurchaseOrder(
      {this.purchaseOrderId,
      this.importStockId,
      this.importStockName,
      this.seqNo,
      this.vendorId,
      this.vendorName,
      this.products,
      this.vendors,
      this.stocks});

  PurchaseOrder.fromJson(Map<String, dynamic> json) {
    purchaseOrderId = json['purchase_order_id'];
    importStockId = json['import_stock_id'];
    importStockName = json['import_stock_name'];
    seqNo = json['seq_no'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    if (json['vendors'] != null) {
      vendors = new List<Vendor>();
      json['vendors'].forEach((v) {
        vendors.add(new Vendor.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      stocks = new List<Stock>();
      json['stocks'].forEach((v) {
        stocks.add(new Stock.fromJson(v));
      });
    }
  }
}
