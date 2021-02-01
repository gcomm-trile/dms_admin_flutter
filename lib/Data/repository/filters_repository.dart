import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/provider/filter_api.dart';
import 'package:meta/meta.dart';

class FiltersRepository {
  final FilterApiClient apiClient;

  FiltersRepository({@required this.apiClient}) : assert(apiClient != null);

  add(String module, String id, String name,
      List<FilterExpression> filterExpressions) {
    return apiClient.add(module, id, name, filterExpressions);
  }

  Future<List<Filter>> getId(String module) {
    return apiClient.getId(module);
  }

  getDataValues(String module) {
    return apiClient.getDataValues(module);
  }
}
