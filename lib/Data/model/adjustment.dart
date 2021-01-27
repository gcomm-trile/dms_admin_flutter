import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';

class Adjustment {
  String id;
  String inStockId;
  String inStockName;
  String no;
  DateTime createdOn;
  List<Product> products;
  List<Stock> stocks;
  int totalQty;

  Adjustment({
    this.id,
    this.inStockId,
    this.inStockName,
    this.no,
    this.products,
    this.stocks,
    this.totalQty,
  });

  Adjustment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inStockId = json['in_stock_id'];
    inStockName = json['in_stock_name'];
    no = json['no'];
    createdOn = DateTime.parse(json['created_on'].toString().substring(0, 10));
    totalQty = json['total_qty'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
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
