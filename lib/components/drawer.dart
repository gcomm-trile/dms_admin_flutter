import 'package:dms_admin/Pages/Dashboard/dashboard_page.dart';
import 'package:dms_admin/Pages/Order/order_page.dart';
import 'package:dms_admin/Pages/Product/product_page.dart';
import 'package:dms_admin/Pages/Stock/stock_countproduct_page.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_page.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_page.dart';
import 'package:dms_admin/Pages/Stock/stock_page.dart';
import 'package:dms_admin/Pages/Visit/widgets/visit_page.dart';
import 'package:dms_admin/router.dart';
import 'package:flutter/material.dart';

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
            text: 'Dashboard',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DashboardPage()));
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
          _createDrawerItem(
            icon: Icons.event_busy,
            text: 'Order',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => OrderPage()));
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
                      color: Colors.white,
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
