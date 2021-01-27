import 'filter_expression.dart';

class Filter {
  String filterName;
  String expressions;
  List<FilterExpression> filterExpressions;
  bool isSelected;
  Filter(
      {this.filterName,
      this.expressions,
      this.filterExpressions,
      this.isSelected});

  Filter.fromJson(Map<String, dynamic> json) {
    filterName = json['filter_name'];
    expressions = json['expressions'];
    if (json['filter_expressions'] != null) {
      filterExpressions = new List<FilterExpression>();
      json['filter_expressions'].forEach((v) {
        filterExpressions.add(new FilterExpression.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_name'] = this.filterName;
    data['expressions'] = this.expressions;
    if (this.filterExpressions != null) {
      data['filter_expressions'] =
          this.filterExpressions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
