import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/transaction.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'inventory/transactions';

class InventoryTransactionsApiClient {
  final Dio httpClient;
  InventoryTransactionsApiClient({@required this.httpClient});

  getAll(List<FilterExpression> filterExpressions) async {
    try {
      var response = await httpClient.post(SERVER_URL + baseUrl,
          data: jsonEncode(filterExpressions));
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
