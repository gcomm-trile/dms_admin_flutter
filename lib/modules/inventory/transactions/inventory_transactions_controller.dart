import 'dart:convert';
import 'dart:developer';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/repository/filters_repository.dart';
import 'package:dms_admin/data/repository/inventory_transactions_repository.dart';
import 'package:dms_admin/global_widgets/filter_dialog/filter_dialog.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryTransactionsController extends GetxController {
  final InventoryTransactionsRepository repository;
  final FiltersRepository filtersRepository = Get.find();
  InventoryTransactionsController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;

  var result = List<Product>().obs;

  var stocks = List<Stock>();

  var filters = List<Filter>().obs;
  var filterExpressions = List<FilterExpression>().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAll();
  }

  void getAll() {
    isBusy(true);
    repository.getAll(filterExpressions).then((data) {
      stocks = data.stocks;
      result(data.products);

      filters.add(Filter(
          id: TextHelper.getDefaultGuidString(),
          name: 'Tất cả',
          isSelected: true,
          filterExpressions: List<FilterExpression>()));
      for (var item in data.filters) {
        filters.add(item);
      }

      isBusy(false);

      log('return data  ');
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  int getTongTon() {
    return result
        .map((expense) => expense.inQty)
        .fold(0, (prev, amount) => prev + amount);
  }

  getTongGiaBan() {
    return result
        .map((expense) => expense.inQty * expense.sellPrice)
        .fold(0, (prev, amount) => prev + amount);
  }

  getTongGiaTri() {
    return result
        .map((expense) => expense.totalPriceAvg)
        .fold(0, (prev, amount) => prev + amount);
  }

  getTongLoiNhuan() {
    return result
        .map((expense) =>
            expense.inQty * expense.sellPrice - expense.totalPriceAvg)
        .fold(0, (prev, amount) => prev + amount);
  }

  void updateDataByFilterChange(List<FilterExpression> filterExpressions) {
    repository.getAll(filterExpressions).then((data) {
      result(data.products);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
    });
  }
}
