import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/dashboard.dart';
import 'package:dms_admin/Models/dashboard_tong_hop.dart';
import 'package:dms_admin/Models/product2.dart';
import 'package:get/state_manager.dart';

class DashboardController extends GetxController {
  var report = Dashboard().obs;
  var startDate = DateTime.now().add(Duration(days: -7)).obs;
  var endDate = DateTime.now().obs;
  var isLoading = false.obs;
  RxString filter_city = ''.obs;
  var filter_tuyen = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading.value = true;
    API_HELPER.getReport(startDate.value, endDate.value).then((value) {
      report.value = value;
      isLoading.value = false;
    });
  }

  updateDateTimeRange(List<DateTime> picked) {
    startDate.value = picked[0];
    endDate.value = picked[1];
    fetchData();
    // products.add(product);
  }

  void setFilterCity(String value) {
    filter_city.value = value;
  }
}
