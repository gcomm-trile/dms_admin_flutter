import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/utils/color_helper.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Function(NavigationCallBackModel data) onChangedValue;
  final String selectedModule;

  const MyDrawer({Key key, @required this.selectedModule, this.onChangedValue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorHelper.fromHex('#033382'),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[400], ColorHelper.fromHex('#042863')],
          //border: Border.all(),
        ),
      ),
      width: 150,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.dashboard,
            text: 'Báo cáo',
            onTap: () {
              // Get.to(DashboardPage());
            },
          ),
          _createDrawerItem(
            icon: Icons.view_sidebar,
            text: 'Viếng thăm',
            onTap: () {
              // Get.toNamed(Routes.VISIT);
            },
          ),
          _createDrawerItem(
            icon: Icons.event_busy,
            text: 'Đơn hàng',
            onTap: () {
              // Get.toNamed(Routes.ORDER);
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => OrderPage()));
            },
          ),
          Divider(thickness: 1.5, color: Colors.black),
          _createDrawerItem(
            icon: Icons.inventory,
            text: DrawModule.INVENTORY_TRANSACTIONS,
            onTap: () {
              // Get.toNamed(Routes.INVENTORY_TRANSACTIONS);
            },
          ),
          _createDrawerItem(
            icon: Icons.ac_unit,
            text: DrawModule.INVENTORY_PURCHASE_ORDERS,
            onTap: () {
              // Get.toNamed(Routes.INVENTORY_PURCHASE_ORDERS);
            },
          ),
          _createDrawerItem(
            icon: Icons.swap_horiz,
            text: DrawModule.INVENTORY_TRANSFERS,
            onTap: () {
              // Get.toNamed(Routes.INVENTORY_TRANSFERS);
            },
          ),
          _createDrawerItem(
            icon: Icons.edit,
            text: DrawModule.INVENTORY_ADJUSTMENTS,
            onTap: () {
              // Get.toNamed(Routes.INVENTORY_ADJUSTMENTS);
            },
          ),
          Divider(thickness: 1.5, color: Colors.black),
          ListTile(
            title: Text('0.0.2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/main_top.png"))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("EZ Solution",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
        title: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: selectedModule == text
                    ? TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)
                    : TextStyle(
                        fontSize: 11,
                        color: Colors.white60,
                      ),
              ),
            )
          ],
        ),
        onTap: () {
          print('change module');
          onChangedValue(NavigationCallBackModel(
              module: text, function: DrawFunction.INDEX, id: ''));
        });
  }
}
