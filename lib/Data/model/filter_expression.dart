class FilterExpression {
  String expression;
  String fieldName;
  String logic;
  String value;
  String fieldNameDisplay;
  String logicDisplay;
  String valueDisplay;

  FilterExpression(
      {this.expression,
      this.fieldName,
      this.fieldNameDisplay,
      this.logic,
      this.logicDisplay,
      this.value,
      this.valueDisplay});

  String getDisplayName() {
    return '$fieldNameDisplay $logicDisplay $valueDisplay';
  }

  FilterExpression.fromJson(Map<String, dynamic> json) {
    expression = json['expression'];
    fieldName = json['field_name'];
    logic = json['logic'];
    value = json['value'];
    fieldNameDisplay = json['field_name_display'];
    logicDisplay = json['logic_display'];
    valueDisplay = json['value_display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expression'] = this.expression;
    data['field_name'] = this.fieldName;
    data['logic'] = this.logic;
    data['value'] = this.value;
    return data;
  }
}
