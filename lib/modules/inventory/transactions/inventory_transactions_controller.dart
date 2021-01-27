import 'dart:developer';

import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/transaction.dart';
import 'package:dms_admin/data/repository/inventory_transactions_repository.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryTransactionsController extends GetxController {
  final selectedFilterIndex = 0.obs;
  final InventoryTransactionsRepository repository;
  InventoryTransactionsController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  var result = List<Product>().obs;
  var filters = List<Filter>().obs;
  void getAll() {
    isBusy(true);
    repository.getAll().then((data) {
      result(data.products);

      filters.add(Filter(filterName: 'Tất cả', isSelected: true));
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
        .map((expense) => expense.inStockQty)
        .fold(0, (prev, amount) => prev + amount);
  }

  getTongGiaBan() {
    return result
        .map((expense) => expense.inStockQty * expense.sellPrice)
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
            expense.inStockQty * expense.sellPrice - expense.totalPriceAvg)
        .fold(0, (prev, amount) => prev + amount);
  }

  createDataSource() {
    var dataSource = <DataRow>[];
    for (var item in result) {
      dataSource.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(item.stockName)),
          DataCell(Row(
            children: [
              Image.network(
                item.imagePath,
                width: kSizeProductImageWidth,
                height: kSizeProductImageHeight,
              ),
              Expanded(
                child: Text(item.name),
              )
            ],
          )),
          DataCell(Text(item.inStockQty.toString())),
          DataCell(Text(item.inStockQty.toString())),
          DataCell(Text(item.inStockQty.toString())),
          DataCell(Text(kNumberFormat.format(item.sellPrice))),
        ],
      ));
    }

    return dataSource;
  }

  void selectedFilter(Filter filter, int index) {
    for (int i = 0; i < filters.length; i++) {
      setFilter(i, index == i ? true : false);
    }
  }

  void setFilter(int i, bool value) {
    var item = filters[i];
    item.isSelected = value;
    filters[i] = item;
  }
}
