class DashboardTongHop {
  String province;
  int countVisit;
  int countStoreOrder;
  int countOrder;
  int sumOrderPrice;

  DashboardTongHop(
      {this.province,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice});

  DashboardTongHop.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    countVisit = json['count_visit'];
    countStoreOrder = json['count_store_order'];
    countOrder = json['count_order'];
    sumOrderPrice = json['sum_order_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['count_visit'] = this.countVisit;
    data['count_store_order'] = this.countStoreOrder;
    data['count_order'] = this.countOrder;
    data['sum_order_price'] = this.sumOrderPrice;
    return data;
  }
}
