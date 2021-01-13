import 'package:dms_admin/data/provider/inventory_purchase_order_api.dart';
import 'package:meta/meta.dart';

class InventoryPurchaseOrderRepository {
  final InventoryPurchaseOrderApiClient apiClient;

  InventoryPurchaseOrderRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }

  getId(String purchaseOrderId) {
    return apiClient.getId(purchaseOrderId);
  }
}
