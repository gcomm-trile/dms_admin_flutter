import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/adjustment.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'inventory/adjustments';

class InventoryAdjustmentsApiClient {
  final Dio httpClient;
  InventoryAdjustmentsApiClient({@required this.httpClient});

  getAll() async {
    try {
      print('call ' + SERVER_URL + baseUrl);
      var response = await httpClient.get(SERVER_URL + baseUrl);
      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => Adjustment.fromJson(x)).toList();
        print('result count ' + result.length.toString());
        return result;
      } else
        print('error -get');
    } catch (_) {
      print(_.toString());
    }
  }

  getId(String id) async {
    try {
      print('call ' + SERVER_URL + baseUrl + '/' + id);
      var response = await httpClient.get(SERVER_URL + baseUrl + '/' + id);
      if (response.statusCode == 200) {
        //print(response.data);
        return Adjustment.fromJson(response.data);
      } else
        print('error -get');
    } catch (_) {
      print(_.toString());
    }
  }

  add(Adjustment value) async {
    final jobsListAPIUrl = SERVER_URL + baseUrl + '';
    // '/add?id=${value.id}&in_stock_id=${value.inStockId}&plan_date=${value.planDate}&vendor_id=${value.vendorId}';
    print("POST $jobsListAPIUrl");

    final response =
        await httpClient.post(jobsListAPIUrl, data: jsonEncode(value.products));
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.data == 'Ok')
        return '';
      else
        return response.data;
    } else {
      return response.data;
    }
  }

  nhanHang(Adjustment value) async {
    final jobsListAPIUrl = SERVER_URL + baseUrl + '/nhanHang?id=${value.id}';
    print("POST $jobsListAPIUrl");
    print(jsonEncode(value.products));
    final response =
        await httpClient.post(jobsListAPIUrl, data: jsonEncode(value.products));
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.data == 'Ok')
        return '';
      else
        return response.data;
    } else {
      return response.data;
    }
  }
}
