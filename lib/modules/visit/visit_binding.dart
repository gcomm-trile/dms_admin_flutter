import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:dms_admin/modules/visit/visit_controller.dart';
import 'package:get/get.dart';

class VisitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VisitRepository(dio: Get.find()));
    Get.lazyPut<VisitController>(() => VisitController(repository: Get.find()));
  }
}
