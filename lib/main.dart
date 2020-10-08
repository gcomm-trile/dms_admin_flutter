import 'package:dms_admin/Pages/Order/order_page.dart';
import 'package:dms_admin/Pages/Product/product_page.dart';
import 'package:dms_admin/Pages/Login/login_page.dart';
import 'package:dms_admin/Pages/Product/product_detail_page.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_export_page.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_page.dart';
import 'package:dms_admin/Pages/Stock/stock_page.dart';
import 'package:dms_admin/components/drawer.dart';
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
      home: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Phiếu xuất"),
        ),
        body: StockDecreaseExportPage(
          phieuXuatId: '4412ba53-e08c-4969-8423-c25692f1c158',
          stockId: '7F7DFD24-D206-45B2-A9D9-E0F32EDFCC81',
        ),
      ),
    );
  }
}
