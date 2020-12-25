import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/dashboard_user.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:get/state_manager.dart';

class DashboardUserController extends GetxController {
  var isLoading = LoadStatus.success.obs;

  var dataApi = <DashboardUser>[];
  var data = <DashboardUser>[].obs;

  var startDate = DateTime.now().add(Duration(days: -7)).obs;
  var endDate = DateTime.now().obs;

  var provinces = <String>[].obs;
  var filterProvince = ''.obs;
  var routes = <String>[].obs;
  var filterRoute = ''.obs;
  var users = <String>[].obs;
  var filterUser = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading(LoadStatus.loading);

    API_HELPER.getReportNVBH(startDate.value, endDate.value).then((value) {
      dataApi = value;
      if (value.length > 0) {
        updateProvinces();
        filterProvince(value[0].province);
        updateRoute();
        filterRoute(value[0].routeName);
        updateUsers();
        filterUser(value[0].fullName);
        updateData();
      }
      isLoading(LoadStatus.success);
    }, onError: (error, stackTrace) {});
  }

  void updateData() {
    data(dataApi
        .where((element) =>
            element.province == filterProvince.value &&
            element.routeName == filterRoute.value &&
            element.fullName == filterUser.value)
        .toList());
    log('refresh data ' + filterUser.value);
  }

  updateDateTimeRange(List<DateTime> picked) {
    startDate.value = picked[0];
    endDate.value = picked[1];
    fetchData();
    // products.add(product);
  }

  void setFilterProvince(String value) {
    log('run setFilterProvince :' + value);
    filterProvince(value);
    log(filterProvince.value);
    updateRoute();
    log(filterRoute.value);
    updateUsers();
    setFilterUser(filterUser.value);
  }

  void setFilterRoute(String value) {
    filterRoute(value);
    updateUsers();
    setFilterUser(filterUser.value);
  }

  void setFilterUser(String value) {
    log('call setFilterUser ' + value);
    filterUser(value);
    updateData();
  }

  void updateProvinces() {
    var result = <String>[];
    for (var item in dataApi) {
      if (!result.contains(item.province)) {
        result.add(item.province);
      }
    }
    provinces(result);
  }

  void updateRoute() {
    log('call update route ' + filterProvince.value);
    var result = <String>[];
    if (filterProvince.value.isNotEmpty) {
      for (var item in dataApi) {
        if (!result.contains(item.routeName) &&
            item.province == filterProvince.value) {
          result.add(item.routeName);
        }
      }
    }
    routes(result);
    filterRoute.value = routes[0];
  }

  void updateUsers() {
    log('call update nvbh ' + filterProvince.value + ' | ' + filterRoute.value);
    var result = <String>[];
    if (filterProvince.value.isNotEmpty && filterRoute.value.isNotEmpty) {
      for (var item in dataApi) {
        if (!result.contains(item.fullName) &&
            item.province == filterProvince.value &&
            item.routeName == filterRoute.value &&
            item.fullName != null) {
          result.add(item.fullName);
        }
      }
    }
    users(result);
    filterUser.value = users[0];
    log('filter user=' + filterUser.value);
  }
}
