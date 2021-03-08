class FilterFieldNameValues {
  String fieldName;
  List<FilterValues> filterValues;

  FilterFieldNameValues({this.fieldName, this.filterValues});

  FilterFieldNameValues.fromJson(Map<String, dynamic> json) {
    fieldName = json['field_name'];
    if (json['filter_values'] != null) {
      filterValues = <FilterValues>[];
      json['filter_values'].forEach((v) {
        filterValues.add(new FilterValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field_name'] = this.fieldName;
    if (this.filterValues != null) {
      data['filter_values'] = this.filterValues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterValues {
  String id;
  String value;

  FilterValues({this.id, this.value});

  FilterValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}
