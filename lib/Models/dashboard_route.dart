class DashboardRoute {
  String routeId;
  String routeName;
  String province;
  int countVisit;
  int countStoreOrder;
  int countOrder;
  int sumOrderPrice;

  DashboardRoute(
      {this.routeId,
      this.routeName,
      this.province,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice});

  DashboardRoute.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    routeName = json['route_name'];
    province = json['province'];
    countVisit = json['count_visit'];
    countStoreOrder = json['count_store_order'];
    countOrder = json['count_order'];
    sumOrderPrice = json['sum_order_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_id'] = this.routeId;
    data['route_name'] = this.routeName;
    data['province'] = this.province;
    data['count_visit'] = this.countVisit;
    data['count_store_order'] = this.countStoreOrder;
    data['count_order'] = this.countOrder;
    data['sum_order_price'] = this.sumOrderPrice;
    return data;
  }
}
