import 'package:dio/dio.dart';
import 'package:dms_admin/data/provider/order_api.dart';
import 'package:dms_admin/data/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio());
    Get.lazyPut(() => OrderRepository(dio: Get.find()));
    Get.lazyPut<OrderController>(() => OrderController(repository: Get.find()));
  }
}
