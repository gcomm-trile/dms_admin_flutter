import 'package:dms_admin/data/provider/order_api.dart';
import 'package:meta/meta.dart';

class OrderRepository {
  final OrderApiClient apiClient;

  OrderRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }

  getId(id) {
    return apiClient.getId(id);
  }
}
