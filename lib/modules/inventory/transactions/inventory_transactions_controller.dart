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
  var filters = List<Filter>().obs;
  var stocks = List<Stock>();
  var filterExpressions = List<FilterExpression>().obs;

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

    var _filterExpressions = List<FilterExpression>();
    for (var filterExpression in filters[index].filterExpressions) {
      _filterExpressions.add(filterExpression);
    }
    filterExpressions(_filterExpressions);
    updateDataByFilterChange();
  }

  void setFilter(int i, bool value) {
    var item = filters[i];
    item.isSelected = value;
    filters[i] = item;
  }

  void showFilterDialog() {
    Get.dialog(
      AlertDialog(
        content: FilterDialog(
          products: result.toList(),
          stocks: stocks,
          savedData: (filterExpression) {
            filterExpressions.add(filterExpression);
            updateDataByFilterChange();
            print('Ok');
          },
        ),
      ),
    );
  }

  void updateDataByFilterChange() {
    repository.getAll(filterExpressions).then((data) {
      result(data.products);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
    });
  }

  void filterExpressionRemove(int index) {
    filterExpressions.removeAt(index);
    updateDataByFilterChange();
  }

  void saveFilter(BuildContext context) {
    var item = filters.where((e) => e.isSelected == true).first;
    String id;
    String name;
    if (item.id == TextHelper.getDefaultGuidString()) {
      var textEditController = TextEditingController();
      Get.dialog(
        AlertDialog(
          title: Text('Tên bộ lọc'),
          content: TextField(
            controller: textEditController,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (textEditController.text.isNotEmpty) {
                    id = Guid.newGuid.value.toString();
                    name = textEditController.text.toUpperCase();
                    print(id);
                    print(name);
                    filtersRepository
                        .add('inventory_transactions', id, name,
                            filterExpressions)
                        .then((data) {
                      filters.clear();
                      filters.add(Filter(
                          id: TextHelper.getDefaultGuidString(),
                          name: 'Tất cả',
                          isSelected: false,
                          filterExpressions: List<FilterExpression>()));
                      for (var item in data) {
                        if (item.id == id) {
                          item.isSelected = true;
                        }
                        filters.add(item);
                      }

                      print('success');
                      Navigator.of(context).pop();
                      UI.showSuccess('Đã cập nhật thành công');
                    }).catchError((e) {
                      print(e.toString());
                      Get.snackbar('Error', e.toString());
                    });
                  }
                },
                child: Text('Lưu bộ lọc')),
          ],
        ),
      );
    } else {
      id = item.id;
      name = item.name;

      filtersRepository
          .add('inventory_transactions', id, name, filterExpressions)
          .then((data) {
        print('success');
        UI.showSuccess('Đã cập nhật thành công');
      }).catchError((e) {
        print(e.toString());
        Get.snackbar('Error', e.toString());
      });
    }
  }
}
