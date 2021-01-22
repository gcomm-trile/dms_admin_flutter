import 'package:dio/dio.dart';

import 'package:dms_admin/data/provider/inventory_transactions_api.dart';
import 'package:dms_admin/data/provider/inventory_transfers_api.dart';
import 'package:dms_admin/data/provider/product_api.dart';
import 'package:dms_admin/data/repository/inventory_transactions_repository.dart';
import 'package:dms_admin/data/repository/product_repository.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_controller.dart';
import 'package:dms_admin/modules/inventory/transfers/new/inventory_transfer_new_controller.dart';
import 'package:dms_admin/modules/product/search/product_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';

import 'data/provider/inventory_purchase_orders_api.dart';
import 'data/repository/inventory_purchase_orders_repository.dart';
import 'data/repository/inventory_transfers_repository.dart';
import 'modules/inventory/purchaseOrders/import/inventory_purchase_order_import_controller.dart';
import 'modules/inventory/purchaseOrders/index/inventory_purchase_orders_controller.dart';
import 'modules/inventory/purchaseOrders/new/inventory_purchase_order_new_controller.dart';

import 'modules/inventory/transfers/index/inventory_transfers_controller.dart';
import 'routes/app_pages.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  Get.lazyPut(() => Dio());

  Get.lazyPut(() => InventoryTransfersApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryTransfersRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryTransfersController(repository: Get.find()));
  Get.lazyPut(() => InventoryTransferNewController(repository: Get.find()));

  Get.lazyPut(() => InventoryTransactionsApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryTransactionsRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryTransactionsController(repository: Get.find()));

  Get.lazyPut(() => InventoryPurchaseOrdersApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryPurchaseOrdersRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryPurchaseOrdersController(repository: Get.find()));
  Get.lazyPut(
      () => InventoryPurchaseOrderImportController(repository: Get.find()));
  Get.lazyPut(
      () => InventoryPurchaseOrderNewController(repository: Get.find()));

  Get.lazyPut(() => ProductApiClient(httpClient: Get.find()));
  Get.lazyPut(() => ProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => ProductSearchController(repository: Get.find()));

  Dio dio = Get.find();
  dio.options.headers["Session-ID"] = '2EF87A1E-5C47-4784-B9E7-5A2438DE308F';
  // Get.put(DashboardTongHopController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
