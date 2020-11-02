import 'package:dms_admin/data/provider/visit_api.dart';
import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:dms_admin/modules/visit/visit_detail_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VisitDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitDetailController>(() => VisitDetailController(
        repository: VisitRepository(
            apiClient: VisitApiClient(httpClient: http.Client()))));
  }
}
