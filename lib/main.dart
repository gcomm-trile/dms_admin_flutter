import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  Get.lazyPut(() => Dio());
  // Get.put(DashboardTongHopController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => LoginPage(), binding: LoginBinding()),
      //   GetPage(
      //       name: '/visits', page: () => VisitPage(), binding: VisitBinding()),
      //   GetPage(
      //       name: '/orders', page: () => OrderPage(), binding: OrderBinding()),
      // GetPage(
      //   name: '/visitdetail',
      //   page: () =>
      //       VisitDetailPage(visitId: 'c6f7c90e-4c7d-438b-bbab-4c83b3112928'),
      //   // binding: VisitDetailBinding()
      // ),

      // home: Scaffold(
      //   body:  LoginPae
      //   // body: VisitDetailPage(
      //   //   visitId: 'c6f7c90e-4c7d-438b-bbab-4c83b3112928',
      //   //   //  phieuXuatId: '4412ba53-e08c-4969-8423-c25692f1c158',
      //   //   // stockId: '7F7DFD24-D206-45B2-A9D9-E0F32EDFCC81',
      //   // ),
      // ),
    );
  }
}
