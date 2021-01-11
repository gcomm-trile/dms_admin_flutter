import 'package:dms_admin/data/provider/inventory_transaction_api.dart';
import 'package:dms_admin/data/repository/inventory_transactions.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transaction_controller.dart';
import 'package:get/get.dart';

class InventoryTransactionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryTransactionsController>(
        () => InventoryTransactionsController(
              repository: InventoryTransactionsRepository(
                apiClient: InventoryTransactionApiClient(
                  httpClient: Get.find(),
                ),
              ),
            ));
  }
}
