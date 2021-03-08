import 'package:dms_admin/data/model/category_model.dart';
import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/utils/datetime_helper.dart';

class AdjustmentListModel {
  List<AdjustmentModel> adjustments;
  List<Filter> filters;
  List<CategoryModel> adjustmentReasons;
  List<Stock> stocks;

  AdjustmentListModel(
      {this.adjustments, this.filters, this.adjustmentReasons, this.stocks});

  AdjustmentListModel.fromJson(Map<String, dynamic> json) {
    if (json['adjustments'] != null) {
      adjustments = <AdjustmentModel>[];
      json['adjustments'].forEach((v) {
        adjustments.add(new AdjustmentModel.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filters = <Filter>[];
      json['filters'].forEach((v) {
        filters.add(new Filter.fromJson(v));
      });
    }

    if (json['adjustment_reasons'] != null) {
      adjustmentReasons = <CategoryModel>[];
      json['adjustment_reasons'].forEach((v) {
        adjustmentReasons.add(new CategoryModel.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      stocks = <Stock>[];
      json['stocks'].forEach((v) {
        stocks.add(new Stock.fromJson(v));
      });
    }
  }
}

class AdjustmentItemModel {
  AdjustmentModel adjustment;
  List<CategoryModel> adjustmentReasons;
  List<Stock> stocks;

  AdjustmentItemModel({this.adjustment, this.adjustmentReasons, this.stocks});

  AdjustmentItemModel.fromJson(Map<String, dynamic> json) {
    adjustment = json['adjustment'] != null
        ? new AdjustmentModel.fromJson(json['adjustment'])
        : null;

    if (json['adjustment_reasons'] != null) {
      adjustmentReasons = new List<CategoryModel>();
      json['adjustment_reasons'].forEach((v) {
        adjustmentReasons.add(new CategoryModel.fromJson(v));
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

class AdjustmentModel {
  String id;
  String no;
  String inStockId;
  String inStockName;
  DateTime createdOn;
  int totalQty;
  int reasonId;
  String reasonName;
  List<Product> products;

  AdjustmentModel(
      {this.id,
      this.no,
      this.inStockId,
      this.inStockName,
      this.createdOn,
      this.totalQty,
      this.reasonId,
      this.reasonName,
      this.products});

  AdjustmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    inStockId = json['in_stock_id'];
    inStockName = json['in_stock_name'];
    createdOn = DateTimeHelper.text2Date(json['created_on']);
    totalQty = json['total_qty'];
    reasonId = json['reason_id'];
    reasonName = json['reason_name'];
    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }
}
