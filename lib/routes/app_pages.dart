import 'package:dms_admin/modules/home_page.dart';
import 'package:dms_admin/modules/home_view/home_view.dart';
import 'package:dms_admin/modules/inventory/adjustments/index/inventory_adjustments_page.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/import/inventory_purchase_order_import.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/index/inventory_purchase_orders.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_page.dart';
import 'package:dms_admin/modules/inventory/transfers/index/inventory_transfers_page.dart';
import 'package:dms_admin/modules/inventory/transfers/new/inventory_transfer_new_page.dart';
import 'package:dms_admin/modules/login/login_binding.dart';
import 'package:dms_admin/modules/login/login_page.dart';
import 'package:dms_admin/modules/order/order_binding.dart';
import 'package:dms_admin/modules/order/order_page.dart';
import 'package:dms_admin/modules/visit/visit_binding.dart';
import 'package:dms_admin/modules/visit/visit_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
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
      name: Routes.INVENTORY_TRANSACTIONS,
      page: () => InventoryTransactionsPage(),
      // binding: InventoryTransactionsBinding(),
    ),
    GetPage(
      name: Routes.INVENTORY_PURCHASE_ORDERS,
      page: () => InventoryPurchaseOrdersPage(),
    ),
    GetPage(
      name: Routes.INVENTORY_TRANSFERS,
      page: () => InventoryTransfersPage(),
    ),
    GetPage(
      name: Routes.INVENTORY_ADJUSTMENTS,
      page: () => InventoryAdjustmentsPage(),
    ),
    GetPage(
      name: Routes.INVENTORY_TRANSFERS_NEW,
      page: () => InventoryTransferNewPage(
        id: '8c6e643c-be53-4392-b848-3b65b269bb47',
      ),
    ),
    GetPage(
      name: Routes.INVENTORY_PURCHASE_ORDERS_NEW,
      page: () => InventoryPurchaseOrderImportPage(
        id: '876848c0-6073-4ffb-9b45-eb32c3842a57',
      ),
    ),
  ];
}
