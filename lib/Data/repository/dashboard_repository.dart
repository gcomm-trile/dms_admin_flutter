import 'package:dms_admin/data/provider/dashboard_api.dart';
import 'package:meta/meta.dart';

class DashboardRepository {
  final DashboardApiClient apiClient;

  DashboardRepository({@required this.apiClient}) : assert(apiClient != null);

  getAll(int filter, int level, String khuvuc, String routeId, String userId) {
    return apiClient.getAll(filter, level, khuvuc, routeId, userId);
  }
}
