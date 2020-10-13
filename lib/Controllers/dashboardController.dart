import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/dashboard.dart';
import 'package:dms_admin/Models/dashboard_tong_hop.dart';
import 'package:dms_admin/Models/product2.dart';
import 'package:get/state_manager.dart';

class DashboardController extends GetxController {
  var data = List<DashboardTongHop>().obs;
  var count = 0.obs;
  var startDate = DateTime.now().add(Duration(days: -7)).obs;
  var endDate = DateTime.now().obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading.value = true;
    API_HELPER.getReportTongHop(startDate.value, endDate.value).then((value) {
      data.value = value;
      isLoading.value = false;
    });
  }

  updateDateTimeRange(List<DateTime> picked) {
    startDate.value = picked[0];
    endDate.value = picked[1];
    fetchData();
    // products.add(product);
  }
}
