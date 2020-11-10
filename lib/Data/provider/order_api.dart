import 'dart:convert';
import 'package:dms_admin/data/api_helper.dart';
import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

const baseUrl = SERVER_URL + 'orders';

class OrderApiClient {
  http.Client httpClient;
  OrderApiClient({@required this.httpClient});

  getAll() async {
    try {
      var response =
          await httpClient.get(baseUrl, headers: API_HELPER.getHeaders());
      if (response.statusCode == 200) {
        print('call getall api ${response.statusCode}');
        List jsonResponse = json.decode(response.body);

        var listMyModel =
            jsonResponse.map((item) => new Order.fromJson(item)).toList();
        print('call getall api return ${listMyModel.length} ');
        return listMyModel;
      } else {
        print('call getall api ${response.statusCode}');
        var res = "{\"status\":" +
            response.statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            response.body +
            "}";
        print('call getall api error ${res}');
        throw new Exception(res);
      }
    } catch (ex) {
      print('call getall api error ${ex.toString()}');
      throw new Exception(ex.toString());
    }
  }

  getId(id) async {
    try {
      var response = await httpClient.get(
        baseUrl + '/' + id,
        headers: API_HELPER.getHeaders(),
      );
      print(baseUrl + '/' + id);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map parsed = json.decode(response.body);
        print('return value');
        return Order.fromJson(parsed);
      } else
        print('erro -get');
    } catch (_) {}
  }
}
