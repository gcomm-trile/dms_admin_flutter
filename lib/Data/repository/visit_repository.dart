import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/data/provider/visit_api.dart';
import 'package:meta/meta.dart';

class VisitRepository {
  final VisitApiClient apiClient;

  VisitRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }

  getId(id) {
    return apiClient.getId(id);
  }
}
