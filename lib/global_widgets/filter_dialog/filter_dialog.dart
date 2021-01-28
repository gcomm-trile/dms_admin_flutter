import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/global_widgets/filter_dialog/fliter_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FilterDialog extends StatelessWidget {
  final FilterController controller = FilterController(repository: Get.find());
  final List<Stock> stocks;
  final List<Product> products;
  final Function(FilterExpression filterExpression) savedData;
  FilterDialog({
    Key key,
    this.savedData,
    this.stocks,
    this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<FilterController>(
      init: controller,
      initState: (state) => controller.onInitData(stocks, products),
      builder: (_) {
        print('rebuild');

        return controller.isBusy.value == true
            ? CircularProgressIndicator()
            : Container(
                height: 250,
                child: Column(
                  children: [
                    Text(
                      'Thêm điều kiện lọc',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownSearch<String>(
                      key: UniqueKey(),
                      mode: Mode.MENU,
                      selectedItem: controller.selectedFieldNameDisplay.value,
                      showSelectedItem: true,
                      items: controller.filterFieldNames,
                      label: "",
                      hint: "",
                      // popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (value) => controller.changedFieldName(value),
                      showClearButton: false,
                      showSearchBox: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    controller.filterLogics.length == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(controller.selectedLogicDisplay.value)
                            ],
                          )
                        : DropdownSearch<String>(
                            mode: Mode.MENU,
                            
                            selectedItem: controller.selectedLogicDisplay.value,
                            showSelectedItem: true,
                            items: controller.filterLogics,
                            onChanged: (value) =>
                                controller.selectedLogicDisplay(value),
                            showClearButton: false,
                            showSearchBox: false,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    controller.isTextBoxNumber.value == true
                        ? TextFormField(
                            controller: controller.textBoxEditController,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: true,
                            ),
                            inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[\-]?\d*'),
                                    replacementString: '')
                              ])
                        : DropdownSearch<String>(
                            key: UniqueKey(),
                            mode: Mode.MENU,
                            showSelectedItem: true,
                            selectedItem: controller.selectedValueDisplay.value,
                            items: controller.filterValues,
                            onChanged: (value) =>
                                controller.selectedValueDisplay(value),
                            showClearButton: false,
                            showSearchBox: true,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              this.savedData(controller.getFilter());
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Thêm điều kiện lọc',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}
