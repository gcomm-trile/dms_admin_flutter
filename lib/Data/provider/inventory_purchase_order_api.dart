import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/inventory_purchase_order.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'inventory/purchaseorders';

class InventoryPurchaseOrderApiClient {
  final Dio httpClient;
  InventoryPurchaseOrderApiClient({@required this.httpClient});

  getAll() async {
    print('session id ${httpClient.options.headers['Session-ID']}');
    try {
      print('call ' + SERVER_URL + baseUrl);
      var response = await httpClient.get(SERVER_URL + baseUrl);
      if (response.statusCode == 200) {
        var result = (response.data as List)
            .map((x) => InventoryPurchaseOrder.fromJson(x))
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
