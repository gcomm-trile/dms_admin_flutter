class DashboardUser {
  String userId;
  String routeId;
  String reportDate;
  String fullName;
  String routeName;
  String province;
  int countVisit;
  int countStoreOrder;
  int countOrder;
  int sumOrderPrice;

  DashboardUser(
      {this.userId,
      this.routeId,
      this.reportDate,
      this.fullName,
      this.routeName,
      this.province,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice});

  DashboardUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    routeId = json['route_id'];
    reportDate = json['report_date'];
    fullName = json['full_name'];
    routeName = json['route_name'];
    province = json['province'];
    countVisit = json['count_visit'];
    countStoreOrder = json['count_store_order'];
    countOrder = json['count_order'];
    sumOrderPrice = json['sum_order_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['route_id'] = this.routeId;
    data['report_date'] = this.reportDate;
    data['full_name'] = this.fullName;
    data['route_name'] = this.routeName;
    data['province'] = this.province;
    data['count_visit'] = this.countVisit;
    data['count_store_order'] = this.countStoreOrder;
    data['count_order'] = this.countOrder;
    data['sum_order_price'] = this.sumOrderPrice;
    return data;
  }
}
