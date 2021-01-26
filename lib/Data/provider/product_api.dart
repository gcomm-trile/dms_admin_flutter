import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'products';

class ProductApiClient {
  final Dio httpClient;
  ProductApiClient({@required this.httpClient});

  getAll(String stockIdIn, String stockIdOut) async {
    try {
      String url = SERVER_URL +
          baseUrl +
          '?stock_id_in=$stockIdIn&stock_id_out=$stockIdOut';
      print(url);
      var response = await httpClient.get(url);

      if (response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => Product.fromJson(x)).toList();
        print('result count ' + result.length.toString());
        return result;
      } else
        print('erro -get');
    } catch (_) {
      print(_.toString());
    }
  }
}
