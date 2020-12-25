import 'package:dms_admin/data/provider/visit_api.dart';
import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:dms_admin/modules/visit/visit_controller.dart';
import 'package:get/get.dart';

class VisitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VisitApiClient(dio: Get.find()));
    Get.lazyPut(() => VisitRepository(visitApiClient: Get.find()));
    Get.lazyPut<VisitController>(() => VisitController(repository: Get.find()));
  }
}
