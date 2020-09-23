import 'dart:convert';
import 'dart:developer';

import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Models/stock.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class API_HELPER {
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json'
  };
  static Future<List<Product>> fetchProduct() async {
    final jobsListAPIUrl = SERVER_URL + '/product';
    final response = await http.get(jobsListAPIUrl, headers: headers);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<Stock>> fetchStock() async {
    final jobsListAPIUrl = SERVER_URL + '/stock';
    final response = await http.get(jobsListAPIUrl, headers: headers);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Stock.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<bool> updateProduct(Product item) async {
    final jobsListAPIUrl = SERVER_URL + '/product';
    log(jsonEncode(item.toJson()));
    final response = await http.post(jobsListAPIUrl,
        headers: headers, body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      log(response.body);
      return true;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<bool> updateStock(Stock item) async {
    final jobsListAPIUrl = SERVER_URL + '/stock';
    log(jsonEncode(item.toJson()));
    final response = await http.post(jobsListAPIUrl,
        headers: headers, body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      log(response.body);
      return true;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
