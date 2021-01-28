class FilterTemplate {
  String module;
  String fieldName;
  String fieldNameDisplay;
  bool isStock;
  bool isProduct;
  bool isTextBoxNumber;
  FilterTemplate(
      {this.module,
      this.fieldName,
      this.fieldNameDisplay,
      this.isStock,
      this.isProduct,
      this.isTextBoxNumber,
      this.logics});
  List<LogicTemplate> logics;

  static List<FilterTemplate> generateInventoryTransactionModule() {
    var result = List<FilterTemplate>();

    result.add(
      FilterTemplate(
        module: 'inventory_transactions',
        fieldName: 'stock_id',
        fieldNameDisplay: 'Kho',
        isStock: true,
        isProduct: false,
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
        module: 'inventory_transactions',
        fieldName: 'qty',
        fieldNameDisplay: 'Tồn',
        isStock: false,
        isProduct: false,
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
        module: 'inventory_transactions',
        fieldName: 'product_id',
        fieldNameDisplay: 'Sản phẩm',
        isStock: false,
        isProduct: true,
        isTextBoxNumber: false,
        logics: [
          LogicTemplate(
            logic: '=',
            logicDisplay: 'là',
          )
        ],
      ),
    );
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
