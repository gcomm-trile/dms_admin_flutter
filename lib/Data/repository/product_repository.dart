import 'package:dms_admin/data/provider/product_api.dart';
import 'package:meta/meta.dart';

class ProductRepository {
  final ProductApiClient apiClient;

  ProductRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll(String stockIdIn, String stockIdOut) {
    return apiClient.getAll(stockIdIn, stockIdOut);
  }
}
