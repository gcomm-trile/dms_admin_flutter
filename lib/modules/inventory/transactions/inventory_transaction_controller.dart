import 'dart:developer';

import 'package:dms_admin/data/model/inventory_transaction.dart';
import 'package:dms_admin/data/repository/inventory_transaction.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryTransactionController extends GetxController {
  final InventoryTransactionRepository repository;
  InventoryTransactionController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  Rx<List<InventoryTransaction>> result = Rx<List<InventoryTransaction>>();

  void getAll() {
    log('run');
    // log('busy' + isBusy.value.toString());
    isBusy(true);
    // log('busy' + isBusy.value.toString());
    repository.getAll().then((data) {
      result.value = data;
      isBusy(false);
      // log('busy' + isBusy.value.toString());
      log('return data  ');
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  int getTongTon() {
    return result.value
        .map((expense) => expense.currentQty)
        .fold(0, (prev, amount) => prev + amount);
  }

  getTongGiaBan() {
    return result.value
        .map((expense) => expense.currentQty * expense.productPrice)
        .fold(0, (prev, amount) => prev + amount);
  }

  getTongGiaTri() {
    return result.value
        .map((expense) => expense.currentQty * expense.productPrice)
        .fold(0, (prev, amount) => prev + amount);
  }

  getTongLoiNhuan() {
    return result.value
        .map((expense) => expense.currentQty * expense.productPrice)
        .fold(0, (prev, amount) => prev + amount);
  }

  createDataSource() {
    var dataSource = <DataRow>[];
    for (var item in result.value) {
      dataSource.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(item.stockName)),
          DataCell(Text(item.productName)),
          DataCell(Text(item.currentQty.toString())),
          DataCell(Text(item.currentQty.toString())),
          DataCell(Text(item.currentQty.toString())),
          DataCell(Text(kNumberFormat.format(item.productPrice))),
        ],
      ));
    }

    return dataSource;
  }
}
