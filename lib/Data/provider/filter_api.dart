import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'filters';

class FilterApiClient {
  final Dio httpClient;
  FilterApiClient({@required this.httpClient});

  add(String module, String id, String name,
      List<FilterExpression> filterExpressions) async {
    try {
      print(SERVER_URL + baseUrl);
      final url =
          SERVER_URL + baseUrl + '?module=${module}&id=${id}&name=${name}';
      print("POST $url");
      var response =
          await httpClient.post(url, data: jsonEncode(filterExpressions));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return (response.data as List).map((x) => Filter.fromJson(x)).toList();
      } else
        return response.data;
    } catch (_) {
      return _.toString();
    }
  }

  Future<List<Filter>> getId(String module) async {
    try {
      print(SERVER_URL + baseUrl);
      final url = SERVER_URL + baseUrl + '?module=$module';
      print("POST $url");
      var response = await httpClient.get(
        url,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return (response.data as List).map((x) => Filter.fromJson(x)).toList();
      } else
        throw Exception('Failed to load jobs from API');
    } catch (_) {
      throw Exception('Failed to load jobs from API');
    }
  }
}
