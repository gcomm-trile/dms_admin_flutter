import 'package:dms_admin/data/provider/visit_api.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

const baseUrl = SERVER_URL + 'orders';

class VisitRepository {
  final VisitApiClient visitApiClient;
  VisitRepository({@required this.visitApiClient});

  getAll(filterDataChange) async {
    return visitApiClient.getAll(filterDataChange);
  }

  getId(id) async {
    return visitApiClient.getId(id);
  }
}
