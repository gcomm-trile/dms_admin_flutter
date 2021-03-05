class ReportModel {
  List<DataChart> dataChart;
  List<DataActivity> dataActivity;

  ReportModel({this.dataChart, this.dataActivity});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['data_chart'] != null) {
      dataChart = <DataChart>[];
      json['data_chart'].forEach((v) {
        dataChart.add(new DataChart.fromJson(v));
      });
    }
    if (json['data_activity'] != null) {
      dataActivity = <DataActivity>[];
      json['data_activity'].forEach((v) {
        dataActivity.add(new DataActivity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataChart != null) {
      data['data_chart'] = this.dataChart.map((v) => v.toJson()).toList();
    }
    if (this.dataActivity != null) {
      data['data_activity'] = this.dataActivity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataChart {
  String id;
  String name;
  int countVisit;
  int countStoreOrder;
  int countOrder;
  int sumOrderPrice;

  DataChart(
      {this.id,
      this.name,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice});

  DataChart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countVisit = json['count_visit'];
    countStoreOrder = json['count_store_order'];
    countOrder = json['count_order'];
    sumOrderPrice = json['sum_order_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count_visit'] = this.countVisit;
    data['count_store_order'] = this.countStoreOrder;
    data['count_order'] = this.countOrder;
    data['sum_order_price'] = this.sumOrderPrice;
    return data;
  }
}

class DataActivity {
  String updatedOn;
  String storeId;
  String storeName;
  String userFullname;
  String province;
  String userId;
  int actionType;
  String content;
  String visitId;

  DataActivity(
      {this.updatedOn,
      this.storeId,
      this.storeName,
      this.userFullname,
      this.province,
      this.userId,
      this.actionType,
      this.content,
      this.visitId});

  DataActivity.fromJson(Map<String, dynamic> json) {
    updatedOn = json['updated_on'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    userFullname = json['user_fullname'];
    province = json['province'];
    userId = json['user_id'];
    actionType = json['action_type'];
    content = json['content'];
    visitId = json['visit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_on'] = this.updatedOn;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['user_fullname'] = this.userFullname;
    data['province'] = this.province;
    data['user_id'] = this.userId;
    data['action_type'] = this.actionType;
    data['content'] = this.content;
    data['visit_id'] = this.visitId;
    return data;
  }
}
