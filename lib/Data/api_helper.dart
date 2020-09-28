import 'dart:convert';
import 'dart:developer';

import 'package:dms_admin/Models/inventory.dart';
import 'package:dms_admin/Models/phieu_nhap.dart';
import 'package:dms_admin/Models/phieu_nhap_detail.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Models/stock.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class API_HELPER {
  static String sessionID = "751a2769-aa03-4840-9bf5-bde97e11c378";
  static Map<String, String> getHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      'Session-ID': sessionID
    };
  }

  static Future<List<Product>> fetchProduct() async {
    final jobsListAPIUrl = SERVER_URL + '/product';
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<Inventory>> fetchInventory(String stock_id) async {
    final jobsListAPIUrl = SERVER_URL + '/inventory?stock_id=' + stock_id;
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Inventory.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<Stock>> fetchStock() async {
    final jobsListAPIUrl = SERVER_URL + '/stock';
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Stock.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<bool> updateProduct(Product item) async {
    final jobsListAPIUrl = SERVER_URL + '/product';
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.post(jobsListAPIUrl,
        headers: getHeaders(), body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      log(response.body);
      return true;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<bool> updateStock(Stock item) async {
    final jobsListAPIUrl = SERVER_URL + '/stock';
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.post(jobsListAPIUrl,
        headers: getHeaders(), body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      log(response.body);
      return true;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<String> login(String username, String password) async {
    final jobsListAPIUrl =
        SERVER_URL + '/login?username=$username&password=$password';
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      log(response.body);
      sessionID = response.body;
      return response.body;
    } else {
      sessionID = "";
      return "";
    }
  }

  static Future<List<PhieuNhapDetail>> fetchPhieuNhapDetail(
      String phieuNhapId) async {
    final jobsListAPIUrl =
        SERVER_URL + '/phieunhapdetail?phieuNhapId=$phieuNhapId';
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      log(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => new PhieuNhapDetail.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<PhieuNhap>> fetchPhieuNhap(String stockId) async {
    final jobsListAPIUrl = SERVER_URL + '/phieunhap?stockId=$stockId ';
    log("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      log(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new PhieuNhap.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
