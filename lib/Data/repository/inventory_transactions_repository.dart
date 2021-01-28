import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/provider/inventory_transactions_api.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:meta/meta.dart';

class InventoryTransactionsRepository {
  final InventoryTransactionsApiClient apiClient;

  InventoryTransactionsRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll(List<FilterExpression> filterExpressions) {
    return apiClient.getAll(filterExpressions);
  }
}
