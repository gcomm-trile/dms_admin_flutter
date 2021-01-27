import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/transaction.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'inventory/transactions';

class InventoryTransactionsApiClient {
  final Dio httpClient;
  InventoryTransactionsApiClient({@required this.httpClient});

  getAll() async {
    try {
      var response = await httpClient.get(SERVER_URL + baseUrl);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Transaction.fromJson(response.data);
      } else
        print('erro -get');
    } catch (_) {
      print(_.toString());
    }
  }
}
