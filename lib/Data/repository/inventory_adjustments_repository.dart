import 'package:dms_admin/data/model/adjustment_model.dart';
import 'package:dms_admin/data/provider/inventory_adjustments_api.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentsRepository {
  final InventoryAdjustmentsApiClient apiClient;

  InventoryAdjustmentsRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }

  getId(String purchaseOrderId) {
    return apiClient.getId(purchaseOrderId);
  }

  dieuchinh(AdjustmentModel value) {
    return apiClient.dieuchinh(value);
  }
}
