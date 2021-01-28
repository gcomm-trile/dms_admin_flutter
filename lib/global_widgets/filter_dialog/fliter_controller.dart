import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/filter_template.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/repository/product_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class FilterController extends GetxController {
  final ProductRepository repository;

  FilterController({@required this.repository}) : assert(repository != null);
  final isBusy = true.obs;
  List<Stock> stocks;
  List<Product> products;
  var textBoxEditController = TextEditingController();
  var filters = FilterTemplate.generateInventoryTransactionModule();
  var selectedFieldNameDisplay = ''.obs;
  var selectedLogicDisplay = ''.obs;
  var selectedValueDisplay = ''.obs;

  var filterFieldNames = <String>[].obs;
  var filterLogics = <String>[].obs;
  var filterValues = <String>[].obs;

  var isTextBoxNumber = false.obs;

  void setFilterLogics(String value) {
    var items = filters
        .where((element) => element.fieldNameDisplay == value)
        .first
        .logics
        .toList();
    filterLogics(items.map((e) => e.logicDisplay).toList());

    selectedLogicDisplay(filterLogics[0]);
  }

  changedFieldName(String value) {
    if (value != selectedFieldNameDisplay.value) {
      selectedFieldNameDisplay(value);
      isTextBoxNumber(filters
          .where((element) => element.fieldNameDisplay == value)
          .first
          .isTextBoxNumber);

      setFilterLogics(value);
      setFilterValues(value);
      selectedValueDisplay('');
    }
  }

  setFilterValues(String value) {
    var item =
        filters.where((element) => element.fieldNameDisplay == value).first;
    if (item.isStock == true) {
      filterValues(
        stocks.map((e) => e.name).toList(),
      );
    }
    if (item.isProduct == true) {
      filterValues(
        products.map((e) => e.name).toList(),
      );
    }
  }

  onInitData(List<Stock> _stocks, List<Product> _products) {
    isBusy(true);
    stocks = _stocks;
    products = _products;
    filterFieldNames(filters.map((e) => e.fieldNameDisplay).toList());
    selectedFieldNameDisplay(filters[0].fieldNameDisplay);
    isTextBoxNumber(filters[0].isTextBoxNumber);
    setFilterLogics(filters[0].fieldNameDisplay);
    setFilterValues(filters[0].fieldNameDisplay);
    isBusy(false);
    super.onInit();
  }

  FilterExpression getFilter() {
    var filterExpression = FilterExpression();

    var fieldNameItem = filters
        .where((element) =>
            element.fieldNameDisplay == selectedFieldNameDisplay.value)
        .first;
    filterExpression.fieldName = fieldNameItem.fieldName;
    filterExpression.fieldNameDisplay = selectedFieldNameDisplay.value;
    filterExpression.expression = filterExpression.fieldName;
    var logicItem = filters
        .where((element) =>
            element.fieldNameDisplay == selectedFieldNameDisplay.value)
        .first
        .logics
        .where((element) => element.logicDisplay == selectedLogicDisplay.value)
        .first;
    filterExpression.logic = logicItem.logic;
    filterExpression.logicDisplay = selectedLogicDisplay.value;
    filterExpression.expression += filterExpression.logic;
    if (fieldNameItem.isTextBoxNumber) {
      filterExpression.value = textBoxEditController.text;
      filterExpression.expression += filterExpression.value;
    } else {
      if (fieldNameItem.isStock) {
        print('is stock');
        filterExpression.value = stocks
            .where((element) => element.name == selectedValueDisplay.value)
            .first
            .id;
        filterExpression.expression += '\'${filterExpression.value}\'';
      }
      if (fieldNameItem.isProduct) {
        filterExpression.value = products
            .where((element) => element.name == selectedValueDisplay.value)
            .first
            .id
            .toString();
        filterExpression.expression += '${filterExpression.value}';
      }
    }

    filterExpression.valueDisplay = selectedValueDisplay.value;

    print('fieldName ' + filterExpression.fieldName);
    print('fieldNameDisplay ' + filterExpression.fieldNameDisplay);
    print('logic ' + filterExpression.logic);
    print('logicDisplay ' + filterExpression.logicDisplay);
    print('value ' + filterExpression.value);
    print('valueDisplay ' + filterExpression.valueDisplay);
    print('expression ' + filterExpression.expression);
    return filterExpression;
  }
}
