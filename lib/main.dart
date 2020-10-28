import 'package:dms_admin/Pages/Login/login_page.dart';
import 'package:dms_admin/Pages/Visit/widgets/visit_page.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:dms_admin/router.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  FluroRouter.setupRouter();

  // Get.put(DashboardTongHopController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: LoginPage(
            //  phieuXuatId: '4412ba53-e08c-4969-8423-c25692f1c158',
            // stockId: '7F7DFD24-D206-45B2-A9D9-E0F32EDFCC81',
            ),
      ),
    );
  }
}
