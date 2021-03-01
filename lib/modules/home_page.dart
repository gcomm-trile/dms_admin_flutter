import 'package:dms_admin/global_widgets/my_drawer.dart';
import 'package:dms_admin/modules/inventory/adjustments/index/inventory_adjustments_view.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/index/inventory_purchase_orders_view.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_page.dart';
import 'package:dms_admin/modules/inventory/transfers/index/inventory_transfers_view.dart';
import 'package:dms_admin/modules/inventory/transfers/new/inventory_transfer_new_page.dart';
import 'package:dms_admin/modules/order/new/order_detail_view.dart';
import 'package:dms_admin/modules/visit/new/visit_detail_view.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/utils/device_screene_type.dart';
import 'package:flutter/material.dart';
import 'inventory/adjustments/new/inventory_adjustment_new_page.dart';
import 'inventory/purchaseOrders/import/inventory_purchase_order_import_view.dart';
import 'inventory/purchaseOrders/new/inventory_purchase_order_new_view.dart';
import 'inventory/transfers/import/inventory_transfer_import_view.dart';
import 'order/index/order_view.dart';
import 'visit/index/visit_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  String selectedModule = DrawModule.VISITS;
  String selectedFunction = DrawFunction.INDEX;
  String id = '';
  homePageMobile(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        drawer: MyDrawer(
          selectedModule: selectedModule,
          onChangedValue: (value) {
            setState(() {
              print('---');
              print(value.id);
              id = value.id;
              selectedModule = value.module;
              selectedFunction = value.function;
              Navigator.pop(context);
            });
          },
        ),
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: mainSection(DeviceScreenType.mobile),
                )
              ],
            ),
            Positioned(
              left: 10,
              top: 5,
              child: InkWell(
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.list,
                      size: 30,
                    ),
                  ),
                ),
                onTap: () => _scaffoldState.currentState.openDrawer(),
              ),
            ),
          ],
        ));
  }

  homePageDesktop(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        MyDrawer(
          selectedModule: selectedModule,
          onChangedValue: (value) {
            setState(() {
              id = value.id;
              selectedModule = value.module;
              selectedFunction = value.function;
            });
          },
        ),
        Expanded(
          child: Container(child: mainSection(DeviceScreenType.desktop)),
        )
      ],
    ));
  }

  mainSection(DeviceScreenType _deviceScreenType) {
    print(selectedModule + ' - ' + selectedFunction);
    switch (selectedModule) {
      case DrawModule.INVENTORY_TRANSACTIONS:
        return selectedFunction == DrawFunction.INDEX
            ? InventoryTransactionsPage(
                deviceScreenType: _deviceScreenType,
              )
            : InventoryTransactionsPage(
                deviceScreenType: _deviceScreenType,
              );
      case DrawModule.ORDERS:
        return selectedFunction == DrawFunction.INDEX
            ? OrdersView(
                onNavigationChanged: (data) {
                  setState(() {
                    id = data.id;
                    selectedModule = data.module;
                    selectedFunction = data.function;
                  });
                },
              )
            : OrderDetailView(
                id: id,
                onNavigationChanged: (data) {
                  setState(() {
                    id = data.id;
                    selectedModule = data.module;
                    selectedFunction = data.function;
                  });
                },
              );
      case DrawModule.VISITS:
        return selectedFunction == DrawFunction.INDEX
            ? VisitsView(
                onNavigationChanged: (data) {
                  setState(() {
                    id = data.id;
                    selectedModule = data.module;
                    selectedFunction = data.function;
                  });
                },
              )
            : VisitDetailView(
                id: id,
                onNavigationChanged: (data) {
                  setState(() {
                    id = data.id;
                    selectedModule = data.module;
                    selectedFunction = data.function;
                  });
                },
              );
      case DrawModule.INVENTORY_ADJUSTMENTS:
        return selectedFunction == DrawFunction.INDEX
            ? InventoryAdjustmentsView(
                onNavigationChanged: (data) {
                  setState(() {
                    id = data.id;
                    selectedModule = data.module;
                    selectedFunction = data.function;
                  });
                },
              )
            : selectedFunction == DrawFunction.NEW
                ? InventoryAdjustmentNewPage(
                    id: id,
                    deviceScreenType: _deviceScreenType,
                    onNavigationChanged: (data) {
                      setState(() {
                        id = data.id;
                        selectedModule = data.module;
                        selectedFunction = data.function;
                      });
                    },
                  )
                : Container();

        break;
      case DrawModule.INVENTORY_PURCHASE_ORDERS:
        return selectedFunction == DrawFunction.INDEX
            ? InventoryPurchaseOrdersView(
                onNavigationChanged: (data) {
                  setState(() {
                    print('new id ' + data.id);
                    id = data.id;
                    selectedModule = data.module;
                    selectedFunction = data.function;
                    print('done set');
                  });
                },
              )
            : selectedFunction == DrawFunction.NEW
                ? InventoryPurchaseOrderNewView(
                    id: id,
                    onNavigationChanged: (data) {
                      setState(() {
                        id = data.id;
                        selectedModule = data.module;
                        selectedFunction = data.function;
                      });
                    },
                  )
                : InventoryPurchaseOrderImportView(
                    id: id,
                    onNavigationChanged: (data) {
                      setState(() {
                        id = data.id;
                        selectedModule = data.module;
                        selectedFunction = data.function;
                      });
                    },
                  );

        break;
      case DrawModule.INVENTORY_TRANSFERS:
        return selectedFunction == DrawFunction.INDEX
            ? InventoryTransfersView(
                onNavigationChanged: (data) {
                  setState(() {
                    id = data.id;
                    selectedModule = data.module;
                    selectedFunction = data.function;
                  });
                },
              )
            : selectedFunction == DrawFunction.NEW
                ? InventoryTransferNewView(
                    id: id,
                    onNavigationChanged: (data) {
                      setState(() {
                        id = data.id;
                        selectedModule = data.module;
                        selectedFunction = data.function;
                      });
                    },
                  )
                : InventoryTransferImportView(
                    id: id,
                    onNavigationChanged: (data) {
                      setState(() {
                        id = data.id;
                        selectedModule = data.module;
                        selectedFunction = data.function;
                      });
                    },
                  );

        break;
      default:
        return Container(
          color: Colors.yellow,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 650) {
      return homePageMobile(context);
    } else {
      return homePageDesktop(context);
    }
  }
}
