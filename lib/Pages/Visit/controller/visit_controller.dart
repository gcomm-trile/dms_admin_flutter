import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/visit.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:get/get.dart';

class VisitController extends GetxController {
  var data = List<Visit>().obs;
  var isLoading = LoadStatus.loading.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading(LoadStatus.loading);

    API_HELPER.listVisit().then((value) {
      data.value = value;
    });
    isLoading(LoadStatus.success);
  }
}
