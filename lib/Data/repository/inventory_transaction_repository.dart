import 'package:dms_admin/data/provider/inventory_transaction_api.dart';
import 'package:meta/meta.dart';

class InventoryTransactionRepository {
  final InventoryTransactionApiClient apiClient;

  InventoryTransactionRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }
}
