import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/vendor.dart';

class PurchaseOrder {
  String id;
  String importStockId;
  String importStockName;
  String no;
  String vendorId;
  String vendorName;
  String note;
  int status;
  String statusName;
  DateTime planImportDate;
  String refDocumentNote;
  List<Product> products;
  List<Vendor> vendors;
  List<Stock> stocks;
  int totalOrderQty;
  int totalImportedQty;

  PurchaseOrder({
    this.id,
    this.importStockId,
    this.importStockName,
    this.no,
    this.vendorId,
    this.vendorName,
    this.products,
    this.vendors,
    this.stocks,
    this.note,
    this.status,
    this.statusName,
    this.totalImportedQty,
    this.totalOrderQty,
  });

  PurchaseOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    importStockId = json['import_stock_id'];
    importStockName = json['import_stock_name'];
    no = json['no'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    status = json['status'];
    statusName = json['status_name'];
    refDocumentNote = json['ref_document_note'];

    planImportDate =
        DateTime.parse(json['plan_import_date'].toString().substring(0, 10));

    totalImportedQty = json['total_imported_qty'];
    totalOrderQty = json['total_order_qty'];
    note = json['note'];

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
