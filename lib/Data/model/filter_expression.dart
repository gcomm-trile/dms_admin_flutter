class FilterExpression {
  String expression;
  String fieldName;
  String logic;
  String value;

  FilterExpression({this.expression, this.fieldName, this.logic, this.value});

  FilterExpression.fromJson(Map<String, dynamic> json) {
    expression = json['expression'];
    fieldName = json['field_name'];
    logic = json['logic'];
    value = json['value'];
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
