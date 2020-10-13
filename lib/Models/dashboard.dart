class Dashboard {
  List<ReportTonghop> reportTonghop;
  List<ReportTuyen> reportTuyen;
  List<ReportNvbh> reportNvbh;
  List<Provinces> provinces;
  List<Routes> routes;
  List<RoutesUser> routesUser;

  Dashboard(
      {this.reportTonghop,
      this.reportTuyen,
      this.reportNvbh,
      this.provinces,
      this.routes,
      this.routesUser});

  Dashboard.fromJson(Map<String, dynamic> json) {
    if (json['report_tonghop'] != null) {
      reportTonghop = new List<ReportTonghop>();
      json['report_tonghop'].forEach((v) {
        reportTonghop.add(new ReportTonghop.fromJson(v));
      });
    }
    if (json['report_tuyen'] != null) {
      reportTuyen = new List<ReportTuyen>();
      json['report_tuyen'].forEach((v) {
        reportTuyen.add(new ReportTuyen.fromJson(v));
      });
    }
    if (json['report_nvbh'] != null) {
      reportNvbh = new List<ReportNvbh>();
      json['report_nvbh'].forEach((v) {
        reportNvbh.add(new ReportNvbh.fromJson(v));
      });
    }
    if (json['provinces'] != null) {
      provinces = new List<Provinces>();
      json['provinces'].forEach((v) {
        provinces.add(new Provinces.fromJson(v));
      });
    }
    if (json['routes'] != null) {
      routes = new List<Routes>();
      json['routes'].forEach((v) {
        routes.add(new Routes.fromJson(v));
      });
    }
    if (json['routes_user'] != null) {
      routesUser = new List<RoutesUser>();
      json['routes_user'].forEach((v) {
        routesUser.add(new RoutesUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportTonghop != null) {
      data['report_tonghop'] =
          this.reportTonghop.map((v) => v.toJson()).toList();
    }
    if (this.reportTuyen != null) {
      data['report_tuyen'] = this.reportTuyen.map((v) => v.toJson()).toList();
    }
    if (this.reportNvbh != null) {
      data['report_nvbh'] = this.reportNvbh.map((v) => v.toJson()).toList();
    }
    if (this.provinces != null) {
      data['provinces'] = this.provinces.map((v) => v.toJson()).toList();
    }
    if (this.routes != null) {
      data['routes'] = this.routes.map((v) => v.toJson()).toList();
    }
    if (this.routesUser != null) {
      data['routes_user'] = this.routesUser.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportTonghop {
  String province;
  int countVisit;
  int countStoreOrder;
  int countOrder;
  int sumOrderPrice;

  ReportTonghop(
      {this.province,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice});

  ReportTonghop.fromJson(Map<String, dynamic> json) {
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

class ReportTuyen {
  String routeId;
  String routeName;
  String province;
  int countVisit;
  int countStoreOrder;
  int countOrder;
  int sumOrderPrice;

  ReportTuyen(
      {this.routeId,
      this.routeName,
      this.province,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice});

  ReportTuyen.fromJson(Map<String, dynamic> json) {
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

class ReportNvbh {
  String userId;
  String routeId;
  String reportDate;
  String fullName;
  String route;
  String province;
  int countVisit;
  int countStoreOrder;
  int countOrder;
  int sumOrderPrice;

  ReportNvbh(
      {this.userId,
      this.routeId,
      this.reportDate,
      this.fullName,
      this.route,
      this.province,
      this.countVisit,
      this.countStoreOrder,
      this.countOrder,
      this.sumOrderPrice});

  ReportNvbh.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    routeId = json['route_id'];
    reportDate = json['report_date'];
    fullName = json['full_name'];
    route = json['route'];
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
    data['route'] = this.route;
    data['province'] = this.province;
    data['count_visit'] = this.countVisit;
    data['count_store_order'] = this.countStoreOrder;
    data['count_order'] = this.countOrder;
    data['sum_order_price'] = this.sumOrderPrice;
    return data;
  }
}

class Provinces {
  String province;

  Provinces({this.province});

  Provinces.fromJson(Map<String, dynamic> json) {
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    return data;
  }
}

class Routes {
  String id;
  String name;
  String province;
  bool isWeek1;
  bool isWeek2;
  bool isWeek3;
  bool isWeek4;
  Null stores;
  Null users;
  Null donViHanhChanh;

  Routes(
      {this.id,
      this.name,
      this.province,
      this.isWeek1,
      this.isWeek2,
      this.isWeek3,
      this.isWeek4,
      this.stores,
      this.users,
      this.donViHanhChanh});

  Routes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
    isWeek1 = json['is_week1'];
    isWeek2 = json['is_week2'];
    isWeek3 = json['is_week3'];
    isWeek4 = json['is_week4'];
    stores = json['stores'];
    users = json['users'];
    donViHanhChanh = json['donViHanhChanh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['province'] = this.province;
    data['is_week1'] = this.isWeek1;
    data['is_week2'] = this.isWeek2;
    data['is_week3'] = this.isWeek3;
    data['is_week4'] = this.isWeek4;
    data['stores'] = this.stores;
    data['users'] = this.users;
    data['donViHanhChanh'] = this.donViHanhChanh;
    return data;
  }
}

class RoutesUser {
  String routeId;
  String userId;
  Null userName;
  String fullName;
  bool isChecked;

  RoutesUser(
      {this.routeId,
      this.userId,
      this.userName,
      this.fullName,
      this.isChecked});

  RoutesUser.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    fullName = json['full_name'];
    isChecked = json['is_checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_id'] = this.routeId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['full_name'] = this.fullName;
    data['is_checked'] = this.isChecked;
    return data;
  }
}
