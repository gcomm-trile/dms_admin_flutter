import 'package:dms_admin/global_widgets/my_drawer.dart';
import 'package:dms_admin/modules/inventory/adjustments/index/inventory_adjustments_page.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_page.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/utils/device_screene_type.dart';
import 'package:flutter/material.dart';
import 'inventory/adjustments/new/inventory_adjustment_new_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  String selectedModule = DrawModule.INVENTORY_ADJUSTMENTS;
  String selectedFunction = DrawFunction.INDEX;
  String id = '';
  homePageMobile(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        drawer: MyDrawer(
          selectedModule: selectedModule,
          onChangedValue: (value) {
            setState(() {
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
              print(value.id);
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
    switch (selectedModule) {
      case DrawModule.INVENTORY_TRANSACTIONS:
        return selectedFunction == DrawFunction.INDEX
            ? InventoryTransactionsPage(
                deviceScreenType: _deviceScreenType,
              )
            : InventoryTransactionsPage(
                deviceScreenType: _deviceScreenType,
              );
      case DrawModule.INVENTORY_ADJUSTMENTS:
        return selectedFunction == DrawFunction.INDEX
            ? InventoryAdjustmentsPage(
                deviceScreenType: _deviceScreenType,
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
