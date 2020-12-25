import 'dart:developer';
import 'package:dms_admin/Pages/Stock/stock_search_page.dart';
import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class OrderController extends GetxController {
  final OrderRepository repository;
  OrderController({@required this.repository}) : assert(repository != null);

  final _orderList = <Order>[].obs;
  get orderList => this._orderList;
  set orderList(value) => this._orderList(value);

  final _order = Order().obs;
  Order get order => this._order.value;
  set order(value) => this._order.value = value;

  getAll() {
    print('order get all');
    repository.getAll().then((data) {
      this.orderList = data;
      print('passed get all');
    }).catchError((onError) {
      print(onError.toString());
      log(onError.toString());
    });
  }

  getId(id) {
    print('order get ID');
    repository.getId(id).then((data) {
      order = data;
    });
  }

  approved() {}

  pickStock() {
    Get.bottomSheet(StockSearchPage());
  }
}
