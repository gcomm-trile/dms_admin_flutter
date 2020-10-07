import 'package:dms_admin/Pages/Order/order_page.dart';
import 'package:dms_admin/Pages/Product/product_page.dart';
import 'package:dms_admin/Pages/Login/login_page.dart';
import 'package:dms_admin/Pages/Product/product_detail_page.dart';
import 'package:dms_admin/Pages/Stock/stock_page.dart';
import 'package:dms_admin/test_page.dart';
import 'package:flutter/material.dart';
import 'package:dms_admin/router.dart';

void main() {
  FluroRouter.setupRouter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OrderPage(),
    );
  }
}
