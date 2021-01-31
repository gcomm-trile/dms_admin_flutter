import 'package:dms_admin/data/model/adjustment_model.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/provider/inventory_adjustments_api.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentsRepository {
  final InventoryAdjustmentsApiClient apiClient;

  InventoryAdjustmentsRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll(List<FilterExpression> filterExpressions) {
    return apiClient.getAll(filterExpressions);
  }

  getId(String purchaseOrderId) {
    return apiClient.getId(purchaseOrderId);
  }

  dieuchinh(AdjustmentModel value) {
    return apiClient.dieuchinh(value);
  }
}
