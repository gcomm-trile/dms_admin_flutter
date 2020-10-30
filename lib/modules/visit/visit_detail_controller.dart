import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/visit_detail.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:get/state_manager.dart';

class VisitDetailController extends GetxController {
  var data = VisitDetail().obs;
  var isLoading = LoadStatus.success.obs;

  String visit_id;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    isLoading(LoadStatus.loading);
    if (visit_id != null) {
      API_HELPER.getVisitDetail(visit_id).then((value) {
        data.value = value;
        isLoading(LoadStatus.success);
      }, onError: (error, stackTrace) {});
    }
  }

  void setVisitId(String value) {
    this.visit_id = value;
    fetchData();
  }
}
