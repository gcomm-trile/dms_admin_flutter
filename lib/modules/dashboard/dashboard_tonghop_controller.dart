import 'package:dms_admin/Data/api_helper.dart';

import 'package:dms_admin/Models/dashboard_tong_hop.dart';

import 'package:dms_admin/share/load_status.dart';
import 'package:get/state_manager.dart';

class DashboardTongHopController extends GetxController {
  var data = <DashboardTongHop>[].obs;
  var startDate = DateTime.now().add(Duration(days: -7)).obs;
  var endDate = DateTime.now().obs;
  var isLoading = LoadStatus.success.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading(LoadStatus.loading);

    API_HELPER.getReportTongHop(startDate.value, endDate.value).then((value) {
      data(value);
      isLoading(LoadStatus.success);
    }, onError: (error, stackTrace) {});
  }

  updateDateTimeRange(List<DateTime> picked) {
    startDate.value = picked[0];
    endDate.value = picked[1];
    fetchData();
    // products.add(product);
  }
}
