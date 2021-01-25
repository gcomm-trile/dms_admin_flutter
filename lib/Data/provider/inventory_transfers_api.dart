import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/model/transfer.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'inventory/transfers';

class InventoryTransfersApiClient {
  final Dio httpClient;
  InventoryTransfersApiClient({@required this.httpClient});

  getAll() async {
    try {
      print('call ' + SERVER_URL + baseUrl);
      var response = await httpClient.get(SERVER_URL + baseUrl);
      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => Transfer.fromJson(x)).toList();
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
      print('call 1 ' + SERVER_URL + baseUrl + '/' + id);
      var response = await httpClient.get(SERVER_URL + baseUrl + '/' + id);
      if (response.statusCode == 200) {
        print(response.data);
        var models = Transfer.fromJson(response.data);
        print('return model');
        return models; //Transfer.fromJson(response.data);
      } else
        print('error -get');
    } catch (_) {
      print(_.toString());
    }
  }

  add(Transfer value) async {
    final apiUrl = SERVER_URL +
        baseUrl +
        '/add?id=${value.id}&out_stock_id=${value.outStockId}&in_stock_id=${value.inStockId}&plan_date=${value.planDate}&ref_document_note=${value.refDocumentNote}&note=${value.note}';
    print("POST $apiUrl");

    final response =
        await httpClient.post(apiUrl, data: jsonEncode(value.products));
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

  import(Transfer value) async {
    final jobsListAPIUrl = SERVER_URL + baseUrl + '/import?id=${value.id}';
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
