import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/inventory_transaction.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'inventory';

class InventoryTransactionApiClient {
  final Dio httpClient;
  InventoryTransactionApiClient({@required this.httpClient});

  getAll() async {
    print('session id ${httpClient.options.headers['Session-ID']}');
    try {
      var response = await httpClient.get(SERVER_URL + baseUrl);
      if (response.statusCode == 200) {
        var result = (response.data as List)
            .map((x) => InventoryTransaction.fromJson(x))
            .toList();
        print('result count ' + result.length.toString());
        return result;
      } else
        print('erro -get');
    } catch (_) {
      print(_.toString());
    }
  }
}
