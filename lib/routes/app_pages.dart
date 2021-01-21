import 'package:dms_admin/modules/inventory/purchaseOrders/index/inventory_purchase_order.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/new/inventory_purchase_order_new.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_page.dart';
import 'package:dms_admin/modules/login/login_binding.dart';
import 'package:dms_admin/modules/login/login_page.dart';
import 'package:dms_admin/modules/order/order_binding.dart';
import 'package:dms_admin/modules/order/order_page.dart';
import 'package:dms_admin/modules/visit/visit_binding.dart';
import 'package:dms_admin/modules/visit/visit_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INVENTORY_PURCHASE_ORDERS;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.VISIT,
      page: () => VisitPage(),
      binding: VisitBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => OrderPage(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => OrderPage(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.INVENTORY_TRANSACTIONS,
      page: () => InventoryTransactionPage(),
      // binding: InventoryTransactionsBinding(),
    ),
    GetPage(
      name: Routes.INVENTORY_PURCHASE_ORDERS,
      page: () => InventoryPurchaseOrderPage(),
    ),
    // GetPage(
    //   name: Routes.INVENTORY_PURCHASE_ORDERS_NEW,
    //   page: () => InventoryPurchaseOrderNewPage(
    //     purchaseOrderId: '89F18C5C-2A76-4B24-977B-5AF9D590C1CE',
    //   ),
    // ),
  ];
}
