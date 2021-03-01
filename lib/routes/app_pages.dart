import 'package:dms_admin/modules/home_page.dart';
import 'package:dms_admin/modules/inventory/adjustments/index/inventory_adjustments_view.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/import/inventory_purchase_order_import_view.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/index/inventory_purchase_orders_view.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_page.dart';
import 'package:dms_admin/modules/inventory/transfers/index/inventory_transfers_view.dart';
import 'package:dms_admin/modules/inventory/transfers/new/inventory_transfer_new_page.dart';
import 'package:dms_admin/modules/login/login_binding.dart';
import 'package:dms_admin/modules/login/login_page.dart';
import 'package:dms_admin/modules/order/index/order_view.dart';
import 'package:dms_admin/modules/visit/index/visit_view.dart';
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
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.VISIT,
      page: () => VisitsView(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => OrdersView(),
    ),
    GetPage(
      name: Routes.INVENTORY_TRANSACTIONS,
      page: () => InventoryTransactionsPage(),
      // binding: InventoryTransactionsBinding(),
    ),
    GetPage(
      name: Routes.INVENTORY_PURCHASE_ORDERS,
      page: () => InventoryPurchaseOrdersView(),
    ),
    GetPage(
      name: Routes.INVENTORY_TRANSFERS,
      page: () => InventoryTransfersView(),
    ),
    GetPage(
      name: Routes.INVENTORY_ADJUSTMENTS,
      page: () => InventoryAdjustmentsView(),
    ),
    GetPage(
      name: Routes.INVENTORY_TRANSFERS_NEW,
      page: () => InventoryTransferNewView(
        id: '8c6e643c-be53-4392-b848-3b65b269bb47',
      ),
    ),
    GetPage(
      name: Routes.INVENTORY_PURCHASE_ORDERS_NEW,
      page: () => InventoryPurchaseOrderImportView(
        id: '876848c0-6073-4ffb-9b45-eb32c3842a57',
      ),
    ),
  ];
}
