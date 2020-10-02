import 'dart:convert';
import 'dart:developer';

import 'package:dms_admin/Models/inventory.dart';
import 'package:dms_admin/Models/phieu_nhap.dart';
import 'package:dms_admin/Models/phieu_nhap_detail.dart';
import 'package:dms_admin/Models/phieu_xuat.dart';
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

  static Future<List<Product>> getProduct() async {
    final jobsListAPIUrl = SERVER_URL + '/product';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<Inventory>> getInventory(String stock_id) async {
    final jobsListAPIUrl = SERVER_URL + '/inventory?stock_id=' + stock_id;
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    print('result ${response.statusCode}');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Inventory.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API:${response.body}');
    }
  }

  static Future<List<Stock>> fetchStock() async {
    final jobsListAPIUrl = SERVER_URL + '/stock';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Stock.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load jobs from API:${response.body}');
    }
  }

  static Future<bool> updateProduct(Product item) async {
    final jobsListAPIUrl = SERVER_URL + '/product';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.post(jobsListAPIUrl,
        headers: getHeaders(), body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      throw Exception('Failed to load jobs from API:${response.body}');
    }
  }

  static Future<bool> updateStock(Stock item) async {
    final jobsListAPIUrl = SERVER_URL + '/stock';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.post(jobsListAPIUrl,
        headers: getHeaders(), body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      throw Exception('Failed to load jobs from API:${response.body}');
    }
  }

  static Future<String> login(String username, String password) async {
    final jobsListAPIUrl =
        SERVER_URL + '/login?username=$username&password=$password';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
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
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => new PhieuNhapDetail.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<PhieuNhap>> getPhieuNhap(String stockId) async {
    final jobsListAPIUrl = SERVER_URL + '/phieunhap?stock_id=$stockId ';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new PhieuNhap.fromJson(item)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load jobs from API :${response.body}');
    }
  }

  static Future<List<PhieuXuat>> getPhieuXuat(String stockId) async {
    final jobsListAPIUrl = SERVER_URL + '/phieuxuat?stock_id=$stockId ';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new PhieuXuat.fromJson(item)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load jobs from API :${response.body}');
    }
  }

  static Future<String> postPhieuNhapDetail(
      String stock_id,
      String phieu_nhap_id,
      String from_stock_id,
      String phieu_xuat_id,
      List<PhieuNhapDetail> items) async {
    final jobsListAPIUrl = SERVER_URL +
        '/PhieuNhapDetail?stock_id=${stock_id}&phieu_nhap_id=${phieu_nhap_id}&from_stock_id=${from_stock_id}&phieu_xuat_id=${phieu_xuat_id}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    print(jsonEncode(items));
    final response = await http.post(jobsListAPIUrl,
        headers: getHeaders(), body: jsonEncode(items));
    if (response.statusCode == 200) {
      log(response.body);
      return "";
    } else {
      return "Failed to load jobs from API";
    }
  }
}
