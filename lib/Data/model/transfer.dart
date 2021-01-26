import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';

class Transfer {
  String id;
  String inStockId;
  String inStockName;
  String outStockId;
  String outStockName;
  String no;
  String note;
  int status;
  String statusName;
  DateTime planDate;
  String refDocumentNote;
  List<Product> products;
  List<Stock> outStocks;
  List<Stock> inStocks;
  int totalQty;
  bool canEdit;
  bool canView;
  bool canReceived;
  bool canCancel;
  Transfer({
    this.id,
    this.inStockId,
    this.outStockId,
    this.no,
    this.products,
    this.inStocks,
    this.outStocks,
    this.note,
    this.status,
    this.statusName,
    this.totalQty,
  });
  Transfer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inStockId = json['in_stock_id'];
    inStockName = json['in_stock_name'];
    outStockId = json['out_stock_id'];
    outStockName = json['out_stock_name'];
    no = json['no'];
    status = json['status'];
    statusName = json['status_name'];
    refDocumentNote = json['ref_document_note'];
    planDate = DateTime.parse(json['plan_date'].toString().substring(0, 10));
    canEdit = json['can_edit'];
    canView = json['can_view'];
    canReceived = json['can_received'];
    canCancel = json['can_cancel'];
    note = json['note'];
    totalQty = json['total_qty'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }

    if (json['in_stocks'] != null) {
      inStocks = new List<Stock>();
      json['in_stocks'].forEach((v) {
        inStocks.add(new Stock.fromJson(v));
      });
    }
    if (json['out_stocks'] != null) {
      outStocks = new List<Stock>();
      json['out_stocks'].forEach((v) {
        outStocks.add(new Stock.fromJson(v));
      });
    }
  }
}
