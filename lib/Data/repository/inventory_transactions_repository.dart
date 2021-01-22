import 'package:dms_admin/data/provider/inventory_transactions_api.dart';
import 'package:meta/meta.dart';

class InventoryTransactionsRepository {
  final InventoryTransactionsApiClient apiClient;

  InventoryTransactionsRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }
}
