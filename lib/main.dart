import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  Get.lazyPut(() => Dio());
  Dio dio = Get.find();
  dio.options.headers["Session-ID"] = '2EF87A1E-5C47-4784-B9E7-5A2438DE308F';
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
      // builder: (context, widget) => ResponsiveWrapper.builder(
      //     BouncingScrollWrapper.builder(context, widget),
      //     maxWidth: 1200,
      //     minWidth: 450,
      //     defaultScale: true,
      //     breakpoints: [
      //       ResponsiveBreakpoint.resize(450, name: MOBILE),
      //       ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //       ResponsiveBreakpoint.autoScale(1000, name: TABLET),
      //       ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      //       ResponsiveBreakpoint.autoScale(2460, name: "4K"),
      //     ],
      // background: Container(color: Color(0xFFF5F5F5))),
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
