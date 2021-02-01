import 'filter_expression.dart';

class Filter {
  String id;
  String name;
  String expressions;
  List<FilterExpression> filterExpressions;

  Filter({
    this.id,
    this.name,
    this.expressions,
    this.filterExpressions,
  });

  Filter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    data['name'] = this.name;
    data['expressions'] = this.expressions;
    if (this.filterExpressions != null) {
      data['filter_expressions'] =
          this.filterExpressions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
