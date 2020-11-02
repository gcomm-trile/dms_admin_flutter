import 'dart:convert';
import 'package:dms_admin/data/api_helper.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

const baseUrl = SERVER_URL + 'visit';

class VisitApiClient {
  http.Client httpClient;
  VisitApiClient({@required this.httpClient});

  getAll() async {
    try {
      var response =
          await httpClient.get(baseUrl, headers: API_HELPER.getHeaders());
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var listMyModel =
            jsonResponse.map((item) => new Visit.fromJson(item)).toList();
        // print(listMyModel.length);
        return listMyModel;
      } else {
        var res = "{\"status\":" +
            response.statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            response.body +
            "}";
        throw new Exception(res);
      }
    } catch (ex) {
      throw new Exception(ex.toString());
    }
  }

// static Future<List<Visit>> listVisit() async {
//     final jobsListAPIUrl = SERVER_URL + '/visit';
//     print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
//     final response = await http.get(jobsListAPIUrl, headers: getHeaders());
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((item) => new Visit.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load jobs from API');
//     }
//   }
  getId(id) async {
    try {
      var response = await httpClient.get(
        baseUrl + '/' + id,
        headers: API_HELPER.getHeaders(),
      );
      print(baseUrl + '/' + id);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Map<String, dynamic> jsonResponse = json.decode(response.body);
        // return VisitDetail.fromJson(jsonResponse);
        final Map parsed = json.decode(response.body);
        return Visit.fromJson(parsed);
      } else
        print('erro -get');
    } catch (_) {}
  }
  //   static Future<VisitDetail> getVisitDetail(String visitId) async {
  //   final jobsListAPIUrl = SERVER_URL + '/visitdetail?visit_id=${visitId}';
  //   print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
  //   final response = await http.get(jobsListAPIUrl, headers: getHeaders());
  //   if (response.statusCode == 200) {
  //     final Map parsed = json.decode(response.body);
  //     return VisitDetail.fromJson(parsed);
  //   } else {
  //     throw Exception('Failed to load jobs from API');
  //   }
  // }
}
