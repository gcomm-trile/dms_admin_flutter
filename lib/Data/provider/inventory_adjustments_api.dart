import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/adjustment_model.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'inventory/adjustments';

class InventoryAdjustmentsApiClient {
  final Dio httpClient;
  InventoryAdjustmentsApiClient({@required this.httpClient});

  getAll(FilterDataChange filterDataChange) async {
    try {
      String url = SERVER_URL +
          baseUrl +
          '?searchText=${filterDataChange.searchText}&filter=' +
          jsonEncode(filterDataChange.filterExpressions);
      print(url);
      var response = await httpClient.get(url);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => AdjustmentModel.fromJson(x))
            .toList();
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
        //print(response.data);
        return AdjustmentItemModel.fromJson(response.data);
      } else
        throw Exception('Failed to load jobs from API');
    } catch (_) {
      throw Exception('Failed to load jobs from API ' + _.toString());
    }
  }

  dieuchinh(AdjustmentModel value) async {
    try {
      final jobsListAPIUrl = SERVER_URL +
          baseUrl +
          '/dieuchinh?id=${value.id}&in_stock_id=${value.inStockId}&reason_id=${value.reasonId}';
      print("POST $jobsListAPIUrl");

      final response = await httpClient.post(jobsListAPIUrl,
          data: jsonEncode(value.products));
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.data == 'Ok')
          return '';
        else
          throw Exception(response.data);
      } else {
        throw Exception('Failed to load jobs from API');
      }
    } catch (_) {
      throw Exception('Failed to load jobs from API ' + _.toString());
    }
  }

  nhanHang(AdjustmentModel value) async {
    try {
      final jobsListAPIUrl = SERVER_URL + baseUrl + '/nhanHang?id=${value.id}';
      print("POST $jobsListAPIUrl");
      print(jsonEncode(value.products));
      final response = await httpClient.post(jobsListAPIUrl,
          data: jsonEncode(value.products));
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.data == 'Ok')
          return '';
        else
          throw Exception('Failed to load jobs from API');
      } else {
        return response.data;
      }
    } catch (_) {
      throw Exception('Failed to load jobs from API ' + _.toString());
    }
  }
}
