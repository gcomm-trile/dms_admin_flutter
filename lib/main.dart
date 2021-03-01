import 'package:dio/dio.dart';
import 'package:dms_admin/data/provider/filter_api.dart';

import 'package:dms_admin/data/provider/inventory_transactions_api.dart';
import 'package:dms_admin/data/provider/inventory_transfers_api.dart';
import 'package:dms_admin/data/provider/order_api.dart';
import 'package:dms_admin/data/provider/product_api.dart';
import 'package:dms_admin/data/repository/filters_repository.dart';
import 'package:dms_admin/data/repository/inventory_transactions_repository.dart';
import 'package:dms_admin/data/repository/order_repository.dart';
import 'package:dms_admin/data/repository/product_repository.dart';
import 'package:dms_admin/global_widgets/filter_dialog/filter_controller.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_controller.dart';
import 'package:dms_admin/modules/inventory/transfers/new/inventory_transfer_new_controller.dart';
import 'package:dms_admin/modules/order/index/order_controller.dart';
import 'package:dms_admin/modules/order/new/order_detail_controller.dart';
import 'package:dms_admin/modules/product/search/product_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';

import 'data/provider/inventory_adjustments_api.dart';
import 'data/provider/inventory_purchase_orders_api.dart';
import 'data/provider/visit_api.dart';
import 'data/repository/inventory_adjustments_repository.dart';
import 'data/repository/inventory_purchase_orders_repository.dart';
import 'data/repository/inventory_transfers_repository.dart';
import 'data/repository/visit_repository.dart';
import 'modules/inventory/adjustments/index/inventory_adjustments_controller.dart';
import 'modules/inventory/adjustments/new/inventory_adjustment_new_controller.dart';
import 'modules/inventory/purchaseOrders/import/inventory_purchase_order_import_controller.dart';
import 'modules/inventory/purchaseOrders/index/inventory_purchase_orders_controller.dart';
import 'modules/inventory/purchaseOrders/new/inventory_purchase_order_new_controller.dart';

import 'modules/inventory/transfers/import/inventory_transfer_import_controller.dart';
import 'modules/inventory/transfers/index/inventory_transfers_controller.dart';
import 'modules/visit/index/visit_controller.dart';
import 'modules/visit/new/visit_detail_controller.dart';
import 'routes/app_pages.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  Get.lazyPut(() => Dio());

  Get.lazyPut(() => InventoryAdjustmentsApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryAdjustmentsRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryAdjustmentsController(repository: Get.find()));
  Get.lazyPut(() => InventoryAdjustmentNewController(repository: Get.find()));

  Get.lazyPut(() => VisitApiClient(httpClient: Get.find()));
  Get.lazyPut(() => VisitRepository(visitApiClient: Get.find()));
  Get.lazyPut(() => VisitController(repository: Get.find()));
  Get.lazyPut(() => VisitDetailController(repository: Get.find()));
  Get.lazyPut(() => InventoryTransfersApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryTransfersRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryTransfersController(repository: Get.find()));
  Get.lazyPut(() => InventoryTransferNewController(repository: Get.find()));
  Get.lazyPut(() => InventoryTransferImportController(repository: Get.find()));
  Get.lazyPut(
      () => InventoryPurchaseOrderImportController(repository: Get.find()));
  Get.lazyPut(() => InventoryTransactionsApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryTransactionsRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryTransactionsController(repository: Get.find()));
  Get.lazyPut(() => OrderApiClient(httpClient: Get.find()));
  Get.lazyPut(() => OrderRepository(apiClient: Get.find()));
  Get.lazyPut(() => OrderController(repository: Get.find()));
  Get.lazyPut(() => OrderDetailController(repository: Get.find()));
  Get.lazyPut(() => InventoryPurchaseOrdersApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryPurchaseOrdersRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryPurchaseOrdersController(repository: Get.find()));
  Get.lazyPut(
      () => InventoryPurchaseOrderImportController(repository: Get.find()));
  Get.lazyPut(
      () => InventoryPurchaseOrderNewController(repository: Get.find()));

  Get.lazyPut(() => FilterApiClient(httpClient: Get.find()));
  Get.lazyPut(() => FiltersRepository(apiClient: Get.find()));

  Get.lazyPut(() => ProductApiClient(httpClient: Get.find()));
  Get.lazyPut(() => ProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => ProductSearchController(repository: Get.find()));
  Get.lazyPut(() => FilterController(repository: Get.find()));

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
// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:flutter/foundation.dart';
// import 'examples/index.dart';

// / main is entry point of Flutter application
// void main() {
//   Desktop platforms aren't a valid platform.
//   if (!kIsWeb) _setTargetPlatformForDesktop();
//   return runApp(MyApp());
// }

// / If the current platform is desktop, override the default platform to
// / a supported platform (iOS for macOS, Android for Linux and Windows).
// / Otherwise, do nothing.
// void _setTargetPlatformForDesktop() {
//   TargetPlatform targetPlatform;
//   if (Platform.isMacOS) {
//     targetPlatform = TargetPlatform.iOS;
//   } else if (Platform.isLinux || Platform.isWindows) {
//     targetPlatform = TargetPlatform.android;
//   }
//   if (targetPlatform != null) {
//     debugDefaultTargetPlatformOverride = targetPlatform;
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light().copyWith(accentColor: Colors.red),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Responsive Examples'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           ListTile(
//             title: Text('Responsive List'),
//             onTap: () => _goToScreen(context, ListExample()),
//           ),
//           ListTile(
//             title: Text('Responsive Layout'),
//             onTap: () => _goToScreen(context, LayoutExample()),
//           ),
//           ListTile(
//             title: Text('Multi Column Layout'),
//             onTap: () => _goToScreen(context, MultiColumnNavigationExample()),
//           ),
//         ],
//       ),
//     );
//   }

//   void _goToScreen(BuildContext context, Widget child) =>
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => child),
//       );
// }
