import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/filter_field_name_values.dart';
import 'package:dms_admin/data/model/filter_template.dart';
import 'package:dms_admin/data/repository/filters_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class FilterController extends GetxController {
  final FiltersRepository repository;

  FilterController({@required this.repository}) : assert(repository != null);
  final isBusy = true.obs;
  var textBoxEditController = TextEditingController();
  var filters = <FilterTemplate>[];
  var selectedFieldNameDisplay = ''.obs;
  var selectedLogicDisplay = ''.obs;
  var selectedValueDisplay = ''.obs;

  var filterFieldNames = <String>[].obs;
  var filterLogics = <String>[].obs;
  var filterValues = <String>[].obs;

  var isTextBoxNumber = false.obs;
  var filterFieldNameValues = <FilterFieldNameValues>[];

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
    if (item.isList == true) {
      filterValues(filterFieldNameValues
          .where((element) => element.fieldName == item.fieldName)
          .first
          .filterValues
          .map((e) => e.value)
          .toList());
    }
  }

  onInitData(String module) {
    isBusy(true);

    repository.getDataValues(module).then((data) {
      filterFieldNameValues = data;
      filters = FilterTemplate.generateFilterTemplate(module);
      filterFieldNames(filters.map((e) => e.fieldNameDisplay).toList());
      selectedFieldNameDisplay(filters[0].fieldNameDisplay);
      isTextBoxNumber(filters[0].isTextBoxNumber);
      setFilterLogics(filters[0].fieldNameDisplay);
      setFilterValues(filters[0].fieldNameDisplay);
      isBusy(false);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });

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
      if (fieldNameItem.isList) {
        filterExpression.value = filterFieldNameValues
            .where((element) => element.fieldName == filterExpression.fieldName)
            .first
            .filterValues
            .where((element) => element.value == selectedValueDisplay.value)
            .first
            .id;
        filterExpression.expression += '\'${filterExpression.value}\'';
      }
    }

    filterExpression.valueDisplay = selectedValueDisplay.value;

    return filterExpression;
  }
}
