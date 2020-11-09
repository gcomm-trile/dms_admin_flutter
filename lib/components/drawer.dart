import 'package:dms_admin/Pages/Dashboard/dashboard_page.dart';
import 'package:dms_admin/Pages/Stock/stock_countproduct_page.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_page.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_page.dart';
import 'package:dms_admin/modules/order/order_binding.dart';
import 'package:dms_admin/modules/order/order_page.dart';
import 'package:dms_admin/modules/visit/visit_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.dashboard,
            text: 'Báo cáo',
            onTap: () {
              Get.to(DashboardPage());
            },
          ),
          _createDrawerItem(
            icon: Icons.view_sidebar,
            text: 'Viếng thăm',
            onTap: () {
              Get.to(VisitPage());
            },
          ),
          _createDrawerItem(
            icon: Icons.event_busy,
            text: 'Đơn hàng',
            onTap: () {
              Get.to(OrderPage(), binding: OrderBinding());
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => OrderPage()));
            },
          ),
          Divider(thickness: 1.5, color: Colors.black),
          _createDrawerItem(
            icon: Icons.inventory,
            text: 'Tồn kho',
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StockCountProductPage()));
            },
          ),
          _createDrawerItem(
            icon: Icons.call_received,
            text: 'Nhập kho',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => StockIncreasePage()));
            },
          ),
          _createDrawerItem(
            icon: Icons.call_made,
            text: 'Xuất kho',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => StockDecreasePage()));
            },
          ),
          Divider(thickness: 1.5, color: Colors.black),
          ListTile(
            title: Text('0.0.1'),
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
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
