import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/model/transfer.dart';
import 'package:dms_admin/data/provider/inventory_transfers_api.dart';
import 'package:meta/meta.dart';

class InventoryTransfersRepository {
  final InventoryTransfersApiClient apiClient;

  InventoryTransfersRepository({@required this.apiClient})
      : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }

  getId(String id) {
    return apiClient.getId(id);
  }

  add(Transfer value) {
    return apiClient.add(value);
  }

  import(Transfer value) {
    return apiClient.import(value);
  }
}