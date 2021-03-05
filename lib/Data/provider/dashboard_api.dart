import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/report_model.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'dashboard';

class DashboardApiClient {
  final Dio httpClient;
  DashboardApiClient({@required this.httpClient});

  getAll(int filter, int level, String khuvuc, String routeId,
      String userId) async {
    try {
      print('call ' +
          SERVER_URL +
          baseUrl +
          '?filter=$filter&level=$level&province=$khuvuc&route_id=$routeId&user_id=$userId');
      var response = await httpClient.get(SERVER_URL +
          baseUrl +
          '?filter=$filter&level=$level&province=$khuvuc&route_id=$routeId&user_id=$userId');

      if (response.statusCode == 200) {
        return ReportModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load jobs from API');
      }
    } catch (_) {
      print(_.toString());
      throw Exception('Failed to load jobs from API ' + _.toString());
    }
  }
}
