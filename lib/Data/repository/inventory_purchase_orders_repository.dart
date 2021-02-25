import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/provider/inventory_purchase_orders_api.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:meta/meta.dart';

class InventoryPurchaseOrdersRepository {
  final InventoryPurchaseOrdersApiClient apiClient;

  InventoryPurchaseOrdersRepository({@required this.apiClient})
      : assert(apiClient != null);

  // getAll() {
  //   return apiClient.getAll();
  // }

  getAll(FilterDataChange filterDataChange) {
    return apiClient.getAll(filterDataChange);
  }

  getId(String purchaseOrderId) {
    return apiClient.getId(purchaseOrderId);
  }

  add(PurchaseOrder value) {
    return apiClient.add(value);
  }

  nhanHang(PurchaseOrder value) {
    return apiClient.nhanHang(value);
  }
}
