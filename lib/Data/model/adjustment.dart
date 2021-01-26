import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/vendor.dart';

class Adjustment {
  String id;
  String inStockId;
  String inStockName;
  String no;
  String vendorId;
  String vendorName;
  int status;
  String statusName;
  DateTime planDate;
  List<Product> products;
  List<Vendor> vendors;
  List<Stock> stocks;
  int totalOrderQty;
  int totalInQty;

  Adjustment({
    this.id,
    this.inStockId,
    this.inStockName,
    this.no,
    this.vendorId,
    this.vendorName,
    this.products,
    this.vendors,
    this.stocks,
    this.status,
    this.statusName,
    this.totalOrderQty,
  });

  Adjustment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inStockId = json['in_stock_id'];
    inStockName = json['in_stock_name'];
    no = json['no'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    status = json['status'];
    statusName = json['status_name'];
    planDate = DateTime.parse(json['plan_date'].toString().substring(0, 10));
    totalOrderQty = json['total_order_qty'];
    totalInQty = json['total_in_qty'];

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
