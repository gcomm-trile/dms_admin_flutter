import 'package:dms_admin/data/provider/inventory_purchase_order_api.dart';
import 'package:dms_admin/data/repository/inventory_purchase_order.dart';
import 'package:get/get.dart';

import '../inventory_purchase_order_controller.dart';

class InventoryPurchaseOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryPurchaseOrderController>(() =>
        InventoryPurchaseOrderController(
            repository: InventoryPurchaseOrderRepository(
                apiClient:
                    InventoryPurchaseOrderApiClient(httpClient: Get.find()))));
  }
}
