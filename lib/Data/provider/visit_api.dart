import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'visits';

class VisitApiClient {
  final Dio httpClient;
  VisitApiClient({@required this.httpClient});

  getAll(FilterDataChange filterDataChange) async {
    try {
      String url = SERVER_URL +
          baseUrl +
          '?searchText=${filterDataChange.searchText}&filter=' +
          jsonEncode(filterDataChange.filterExpressions);
      print(url);
      var response = await httpClient.get(url);
      if (response.statusCode == 200) {
        return (response.data as List).map((x) => Visit.fromJson(x)).toList();
      } else
        throw Exception('Failed to load jobs from API');
    } catch (_) {
      throw Exception('Failed to load jobs from API ' + _.toString());
    }
  }

  getId(String id) async {
    try {
      print('call ' + SERVER_URL + baseUrl + '/' + id);
      var response = await httpClient.get(SERVER_URL + baseUrl + '/' + id);
      if (response.statusCode == 200) {
        print(response.data);
        return Visit.fromJson(response.data);
      } else
        throw Exception('Failed to load jobs from API');
    } catch (_) {
      throw Exception('Failed to load jobs from API ' + _.toString());
    }
  }
}
