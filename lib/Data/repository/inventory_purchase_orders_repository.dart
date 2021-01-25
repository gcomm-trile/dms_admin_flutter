import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/provider/inventory_purchase_orders_api.dart';
import 'package:meta/meta.dart';

class InventoryPurchaseOrdersRepository {
  final InventoryPurchaseOrdersApiClient apiClient;

  InventoryPurchaseOrdersRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }

  getId(String purchaseOrderId) {
    return apiClient.getId(purchaseOrderId);
  }

  add(PurchaseOrder value) {
    return apiClient.add(value);
  }

  import(PurchaseOrder value) {
    return apiClient.import(value);
  }
}