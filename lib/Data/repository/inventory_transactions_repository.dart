import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/provider/inventory_transactions_api.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:meta/meta.dart';

class InventoryTransactionsRepository {
  final InventoryTransactionsApiClient apiClient;

  InventoryTransactionsRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll(FilterDataChange filterDataChange) {
    return apiClient.getAll(filterDataChange);
  }
}
