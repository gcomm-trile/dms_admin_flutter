import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/dashboard_activity.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:get/state_manager.dart';

class DashboardActivityController extends GetxController {
  var dataApi = <DashboardActivity>[];
  var data = <DashboardActivity>[].obs;
  var startDate = DateTime.now().add(Duration(days: -7)).obs;
  var endDate = DateTime.now().obs;
  var isLoading = LoadStatus.success.obs;

  var provinces = <String>[].obs;
  var filterProvince = ''.obs;
  var users = <String>[].obs;
  var filterUser = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading(LoadStatus.loading);
    API_HELPER.getReportActivity(startDate.value, endDate.value).then((value) {
      dataApi = value;
      if (value.length > 0) {
        updateProvinces();
        filterProvince(value[0].province);
        updateUser();
        filterUser(value[0].userFullname);
        updateData();
      }
      isLoading(LoadStatus.success);
    }, onError: (error, stackTrace) {});
  }

  void updateData() {
    data(dataApi
        .where((element) =>
            element.province == filterProvince.value &&
            element.userFullname == filterUser.value)
        .toList());
  }

  updateDateTimeRange(List<DateTime> picked) {
    startDate.value = picked[0];
    endDate.value = picked[1];
    fetchData();
    // products.add(product);
  }

  void setFilterProvince(String value) {
    filterProvince(value);
    updateUser();
    setFilterUser(filterUser.value);
  }

  void setFilterUser(String value) {
    filterUser(value);
    log('filter user ' + filterUser.value);
    updateData();
  }

  void updateProvinces() {
    List<String> result = <String>[];
    for (var item in dataApi) {
      if (!result.contains(item.province)) {
        result.add(item.province);
      }
    }
    provinces(result);
  }

  void updateUser() {
    List<String> result = <String>[];
    if (filterProvince.value.isNotEmpty) {
      for (var item in dataApi) {
        if (!result.contains(item.userFullname) &&
            item.province == filterProvince.value) {
          result.add(item.userFullname);
        }
      }
    }
    users(result);
    filterUser.value = users[0];
  }
}
