import 'package:dms_admin/modules/visit/visit_detail_controller.dart';
import 'package:get/get.dart';

class VisitDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitDetailController>(() => VisitDetailController());
  }
}
