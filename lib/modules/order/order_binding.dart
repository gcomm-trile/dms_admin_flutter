import 'package:dms_admin/data/provider/order_api.dart';
import 'package:dms_admin/data/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(
        repository: OrderRepository(
            apiClient: OrderApiClient(httpClient: http.Client()))));
  }
}
