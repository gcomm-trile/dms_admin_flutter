
import 'package:dms_admin/data/repository/login_repository.dart';
import 'package:dms_admin/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
 
    Get.lazyPut(() => LoginRepository(dio: Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(repository: Get.find()));
    // Get.lazyPut<LoginController>(() => LoginController());
  }
}
