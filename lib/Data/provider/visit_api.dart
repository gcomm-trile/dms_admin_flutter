import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

const baseUrl = SERVER_URL + 'visits';

class VisitApiClient {
  final Dio dio;
  VisitApiClient({@required this.dio});

  getAll() async {
    print('session id ${dio.options.headers['Session-ID']}');
    try {
      var response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        print('call getall api ${response.statusCode} ${response.data}');
        return (response.data as List).map((x) => Visit.fromJson(x)).toList();
      } else {
        print('call getall api ${response.statusCode}');
        var res = "{\"status\":" +
            response.statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            response.data +
            "}";
        print('call getall api error $res');
        throw new Exception(res);
      }
    } catch (ex) {
      print('call getall api error ${ex.toString()}');
      throw new Exception(ex.toString());
    }
  }

  getId(id) async {
    try {
      var response = await dio.get(
        baseUrl + '/' + id,
      );
      print(baseUrl + '/' + id);
      if (response.statusCode == 200) {
        print('call getall api ${response.statusCode} ${response.data}');
        var map = Map<String, dynamic>.from(response.data);
        return Visit.fromJson(map);
      } else
        print('erro -get');
    } catch (_) {
      print('erro -get ${_.toString()}');
    }
  }
}
