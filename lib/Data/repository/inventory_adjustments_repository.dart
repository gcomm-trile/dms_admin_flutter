import 'package:dms_admin/data/model/adjustment_model.dart';
import 'package:dms_admin/data/provider/inventory_adjustments_api.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentsRepository {
  final InventoryAdjustmentsApiClient apiClient;

  InventoryAdjustmentsRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll(FilterDataChange filterDataChange) {
    return apiClient.getAll(filterDataChange);
  }

  getId(String purchaseOrderId) {
    return apiClient.getId(purchaseOrderId);
  }

  dieuchinh(AdjustmentModel value) {
    return apiClient.dieuchinh(value);
  }
}
