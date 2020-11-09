import 'dart:convert';
import 'dart:developer';

import 'package:dms_admin/Models/dashboard.dart';
import 'package:dms_admin/Models/dashboard_activity.dart';
import 'package:dms_admin/Models/dashboard_user.dart';
import 'package:dms_admin/Models/dashboard_route.dart';
import 'package:dms_admin/Models/inventory.dart';
import 'package:dms_admin/Models/phieu_nhap.dart';
import 'package:dms_admin/Models/phieu_nhap_detail.dart';
import 'package:dms_admin/Models/phieu_xuat.dart';
import 'package:dms_admin/Models/phieu_xuat_detail.dart';
import 'package:dms_admin/Models/dashboard_tong_hop.dart';
import 'package:dms_admin/Models/stock.dart';
import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/model/product.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../utils/constants.dart';
import 'model/store.dart';

// ignore: camel_case_types
class API_HELPER {
  static String sessionID = "D51C8585-C2F3-4424-A746-08044712D0A3";
  static Map<String, String> getHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Session-ID': 'D51C8585-C2F3-4424-A746-08044712D0A3'
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

  static Future<Dashboard> getReport(
      DateTime startDate, DateTime endDate) async {
    final jobsListAPIUrl = SERVER_URL +
        '/dashboard?from_date=${DateFormat('yyyy-MM-dd').format(startDate)}&to_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      return Dashboard.fromJson(parsed);
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<Store> getStore(String storeId) async {
    final jobsListAPIUrl = SERVER_URL + '/store?store_id=${storeId}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      final Map parsed = json.decode(response.body);
      var x = Store.fromJson(parsed);
      return x;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<DashboardTongHop>> getReportTongHop(
      DateTime startDate, DateTime endDate) async {
    final jobsListAPIUrl = SERVER_URL +
        '/dashboardtonghop?from_date=${DateFormat('yyyy-MM-dd').format(startDate)}&to_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => new DashboardTongHop.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<DashboardUser>> getReportNVBH(
      DateTime startDate, DateTime endDate) async {
    final jobsListAPIUrl = SERVER_URL +
        '/dashboardnvbh?from_date=${DateFormat('yyyy-MM-dd').format(startDate)}&to_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => new DashboardUser.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<DashboardActivity>> getReportActivity(
      DateTime startDate, DateTime endDate) async {
    final jobsListAPIUrl = SERVER_URL +
        '/DashboardActivity?from_date=${DateFormat('yyyy-MM-dd').format(startDate)}&to_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => new DashboardActivity.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<DashboardRoute>> getReportRoute(
      DateTime startDate, DateTime endDate) async {
    final jobsListAPIUrl = SERVER_URL +
        '/dashboardtuyen?from_date=${DateFormat('yyyy-MM-dd').format(startDate)}&to_date=${DateFormat('yyyy-MM-dd').format(endDate)}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => new DashboardRoute.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<Inventory>> listInventoryProduct() async {
    final jobsListAPIUrl = SERVER_URL + '/inventory';
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

  static Future<List<Stock>> listStocks() async {
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

  static Future<PhieuNhapDetail> getPhieuNhapDetail(String phieuNhapId) async {
    final jobsListAPIUrl =
        SERVER_URL + '/PhieuNhapDetail?phieu_nhap_id=$phieuNhapId';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final Map parsed = json.decode(response.body);
      return PhieuNhapDetail.fromJson(parsed);
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<PhieuXuatDetail> getPhieuXuatDetail(String phieuXuatId) async {
    final jobsListAPIUrl =
        SERVER_URL + '/PhieuXuatDetail?phieu_xuat_id=$phieuXuatId';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final Map parsed = json.decode(response.body);
      return PhieuXuatDetail.fromJson(parsed);
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  static Future<List<PhieuNhap>> listPhieuNhap() async {
    final jobsListAPIUrl = SERVER_URL + '/phieunhap';
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

  static Future<List<PhieuXuat>> listPhieuXuat() async {
    final jobsListAPIUrl = SERVER_URL + '/phieuxuat';
    print("get $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
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

  static Future<List<Order>> listOrder() async {
    final jobsListAPIUrl = SERVER_URL + '/order';
    print("get $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => new Order.fromJson(item)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load jobs from API :${response.body}');
    }
  }

  static Future<Order> getOrder(String order_id) async {
    final jobsListAPIUrl = SERVER_URL + '/orderdetail?order_id=${order_id}';
    print("get $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.get(
      jobsListAPIUrl,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      print(response.body);
      final Map parsed = json.decode(response.body);
      return Order.fromJson(parsed);
    } else {
      print(response.body);
      throw Exception('Failed to load jobs from API :${response.body}');
    }
  }

  static Future<String> postPhieuNhapDetail(
      String import_stock_id,
      String export_stock_id,
      String phieu_nhap_id,
      String phieu_xuat_id,
      List<Product> items) async {
    final jobsListAPIUrl = SERVER_URL +
        '/PhieuNhapDetail?import_stock_id=${import_stock_id}&export_stock_id=${export_stock_id}&phieu_nhap_id=${phieu_nhap_id}&phieu_xuat_id=${phieu_xuat_id}';
    print("POST $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
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

  static Future<String> postPhieuXuatDetail(
      String import_stock_id,
      String export_stock_id,
      String phieu_nhap_id,
      String phieu_xuat_id,
      List<Product> items) async {
    final jobsListAPIUrl = SERVER_URL +
        '/PhieuXuatDetail?import_stock_id=${import_stock_id}&export_stock_id=${export_stock_id}&phieu_nhap_id=${phieu_nhap_id}&phieu_xuat_id=${phieu_xuat_id}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    print(jsonEncode(items));
    final response = await http.post(jobsListAPIUrl,
        headers: getHeaders(), body: jsonEncode(items));
    if (response.statusCode == 200) {
      log(response.body);
      return "";
    } else {
      return response.body;
    }
  }

  static Future<String> postDuyetPhieuXuat(
      String phieu_xuat_id, int status) async {
    final jobsListAPIUrl = SERVER_URL +
        '/DuyetPhieuXuat?phieu_xuat_id=${phieu_xuat_id}&status=${status}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.post(jobsListAPIUrl, headers: getHeaders());
    if (response.statusCode == 200) {
      log(response.body);
      return "";
    } else {
      return response.body;
    }
  }

  static Future<String> postDuyetXuatDonHang(
      String order_id, String export_stock_id, int status) async {
    final jobsListAPIUrl = SERVER_URL +
        '/OrderApproved?order_id=${order_id}&export_stock_id=${export_stock_id}&status=${status}';
    print("call $jobsListAPIUrl with header " + jsonEncode(getHeaders()));
    final response = await http.post(jobsListAPIUrl, headers: getHeaders());
    log(response.body);
    if (response.statusCode == 200) {
      return "";
    } else {
      return 'Lỗi ' + response.body;
    }
  }
}
