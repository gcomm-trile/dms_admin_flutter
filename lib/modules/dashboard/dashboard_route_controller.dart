import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/dashboard_route.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:get/state_manager.dart';

class DashboardRouteController extends GetxController {
  var dataApi = <DashboardRoute>[];
  var data = <DashboardRoute>[].obs;
  var startDate = DateTime.now().add(Duration(days: -7)).obs;
  var endDate = DateTime.now().obs;
  var isLoading = LoadStatus.success.obs;

  var provinces = <String>[].obs;
  var filterProvince = ''.obs;
  var routes = <String>[].obs;
  var filterRoute = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading(LoadStatus.loading);
    API_HELPER.getReportRoute(startDate.value, endDate.value).then((value) {
      dataApi = value;
      if (value.length > 0) {
        updateProvinces();
        filterProvince(value[0].province);
        updateRoute();
        filterRoute(value[0].routeName);
        updateData();
      }
      isLoading(LoadStatus.success);
    }, onError: (error, stackTrace) {});
  }

  void updateData() {
    data(dataApi
        .where((element) =>
            element.province == filterProvince.value &&
            element.routeName == filterRoute.value)
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
    updateRoute();
    setFilterRoute(filterRoute.value);
  }

  void setFilterRoute(String value) {
    filterRoute(value);
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

  void updateRoute() {
    List<String> result = <String>[];
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
}
