import 'package:dio/dio.dart';
import 'package:dms_admin/data/provider/inventory_purchase_order_api.dart';
import 'package:dms_admin/data/provider/inventory_transaction_api.dart';
import 'package:dms_admin/data/provider/product_api.dart';
import 'package:dms_admin/data/repository/inventory_transaction_repository.dart';
import 'package:dms_admin/data/repository/product_repository.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transaction_controller.dart';
import 'package:dms_admin/modules/product/search/product_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';
import 'data/repository/inventory_purchase_order_repository.dart';

import 'modules/inventory/purchaseOrders/inventory_purchase_order_controller.dart';
import 'routes/app_pages.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  Get.lazyPut(() => Dio());

  Get.lazyPut(() => InventoryTransactionApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryTransactionRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryTransactionController(repository: Get.find()));

  Get.lazyPut(() => InventoryPurchaseOrderApiClient(httpClient: Get.find()));
  Get.lazyPut(() => InventoryPurchaseOrderRepository(apiClient: Get.find()));
  Get.lazyPut(() => InventoryPurchaseOrderController(repository: Get.find()));

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
      // builder: (context, widget) => ResponsiveWrapper.builder(
      //     BouncingScrollWrapper.builder(context, widget),
      //     maxWidth: 1200,
      //     minWidth: 450,
      //     defaultScale: true,
      //     breakpoints: [
      //       ResponsiveBreakpoint.resize(450, name: MOBILE),
      //       ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //       ResponsiveBreakpoint.autoScale(1000, name: TABLET),
      //       ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      //       ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      //     ],
      // background: Container(color: Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => LoginPage(), binding: LoginBinding()),
      //   GetPage(
      //       name: '/visits', page: () => VisitPage(), binding: VisitBinding()),
      //   GetPage(
      //       name: '/orders', page: () => OrderPage(), binding: OrderBinding()),
      // GetPage(
      //   name: '/visitdetail',
      //   page: () =>
      //       VisitDetailPage(visitId: 'c6f7c90e-4c7d-438b-bbab-4c83b3112928'),
      //   // binding: VisitDetailBinding()
      // ),

      // home: Scaffold(
      //   body:  LoginPae
      //   // body: VisitDetailPage(
      //   //   visitId: 'c6f7c90e-4c7d-438b-bbab-4c83b3112928',
      //   //   //  phieuXuatId: '4412ba53-e08c-4969-8423-c25692f1c158',
      //   //   // stockId: '7F7DFD24-D206-45B2-A9D9-E0F32EDFCC81',
      //   // ),
      // ),
    );
  }
}
