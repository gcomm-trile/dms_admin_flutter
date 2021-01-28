import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';

import 'filter.dart';

class Transaction {
  List<Product> products;
  List<Filter> filters;
  List<Stock> stocks;
  Transaction({this.products, this.filters});

  Transaction.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filters = new List<Filter>();
      json['filters'].forEach((v) {
        filters.add(new Filter.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      stocks = new List<Stock>();
      json['stocks'].forEach((v) {
        stocks.add(new Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
