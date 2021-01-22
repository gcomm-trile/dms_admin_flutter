import 'package:dio/dio.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

// const baseUrl = 'inventory/transactions';
const baseUrl = 'products';

class ProductApiClient {
  final Dio httpClient;
  ProductApiClient({@required this.httpClient});

  getAll() async {
    print('session id ${httpClient.options.headers['Session-ID']}');
    try {
      print(SERVER_URL + baseUrl);
      var response = await httpClient.get(SERVER_URL + baseUrl);

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
