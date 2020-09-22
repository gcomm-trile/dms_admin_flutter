import 'package:dms_admin/Pages/Home/components/product_page.dart';
import 'package:dms_admin/Pages/Login/login_page.dart';
import 'package:dms_admin/Pages/ProductDetail/product_detail_page.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => ProductPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/product': (context) => ProductPage(),
      },
    );
  }
}
