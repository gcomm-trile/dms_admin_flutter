import 'package:dms_admin/Controllers/dashboardController.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_page.dart';
import 'package:dms_admin/Pages/Stock/stock_countproduct_page.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_page.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_page.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:dms_admin/router.dart';
import 'package:get/get.dart';

void main() {
  FluroRouter.setupRouter();
  Get.put(DashboardController());
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
        body: DashboardPage(
            //  phieuXuatId: '4412ba53-e08c-4969-8423-c25692f1c158',
            // stockId: '7F7DFD24-D206-45B2-A9D9-E0F32EDFCC81',
            ),
      ),
    );
  }
}
