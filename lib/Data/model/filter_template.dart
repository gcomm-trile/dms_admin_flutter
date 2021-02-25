class FilterTemplate {
  String module;
  String fieldName;
  String fieldNameDisplay;
  bool isList;

  bool isTextBoxNumber;
  FilterTemplate(
      {this.module,
      this.fieldName,
      this.fieldNameDisplay,
      this.isList,
      this.isTextBoxNumber,
      this.logics});
  List<LogicTemplate> logics;

  static List<FilterTemplate> generateFilterTemplate(String module) {
    var result = List<FilterTemplate>();

    if (module == 'inventory_transactions') {
      result.add(
        FilterTemplate(
          module: module,
          fieldName: 'stock_id',
          fieldNameDisplay: 'Kho',
          isList: true,
          isTextBoxNumber: false,
          logics: [
            LogicTemplate(
              logic: '=',
              logicDisplay: 'là',
            )
          ],
        ),
      );

      result.add(
        FilterTemplate(
          module: module,
          fieldName: 'qty',
          fieldNameDisplay: 'Tồn',
          isList: false,
          isTextBoxNumber: true,
          logics: [
            LogicTemplate(
              logic: '=',
              logicDisplay: 'bằng',
            ),
            LogicTemplate(
              logic: '>',
              logicDisplay: 'lớn hơn',
            ),
            LogicTemplate(
              logic: '<',
              logicDisplay: 'bé hơn',
            )
          ],
        ),
      );
      result.add(
        FilterTemplate(
          module: module,
          fieldName: 'product_id',
          fieldNameDisplay: 'Sản phẩm',
          isList: true,
          isTextBoxNumber: false,
          logics: [
            LogicTemplate(
              logic: '=',
              logicDisplay: 'là',
            )
          ],
        ),
      );
    }

    if (module == 'inventory_adjustments') {
      result.add(
        FilterTemplate(
          module: module,
          fieldName: 'stock_id',
          fieldNameDisplay: 'Kho',
          isList: true,
          isTextBoxNumber: false,
          logics: [
            LogicTemplate(
              logic: '=',
              logicDisplay: 'là',
            )
          ],
        ),
      );
      result.add(
        FilterTemplate(
          module: module,
          fieldName: 'adjustment_reason_id',
          fieldNameDisplay: 'Lí do',
          isList: true,
          isTextBoxNumber: false,
          logics: [
            LogicTemplate(
              logic: '=',
              logicDisplay: 'là',
            )
          ],
        ),
      );
    }
    if (module == 'inventory_purchase_orders') {
      result.add(
        FilterTemplate(
          module: module,
          fieldName: 'stock_id',
          fieldNameDisplay: 'Kho',
          isList: true,
          isTextBoxNumber: false,
          logics: [
            LogicTemplate(
              logic: '=',
              logicDisplay: 'là',
            )
          ],
        ),
      );
      result.add(
        FilterTemplate(
          module: module,
          fieldName: 'purchase_order_status_id',
          fieldNameDisplay: 'Tình trạng',
          isList: true,
          isTextBoxNumber: false,
          logics: [
            LogicTemplate(
              logic: '=',
              logicDisplay: 'là',
            )
          ],
        ),
      );
    }
    return result;
  }
}

class LogicTemplate {
  String logic;
  String logicDisplay;

  // List<ValueTemplate> values;
  LogicTemplate({
    this.logic,
    this.logicDisplay,

    // this.values,
  });
}

// class ValueTemplate {
//   String value;
//   String valueDisplay;
//   ValueTemplate({this.value, this.valueDisplay});
// }
