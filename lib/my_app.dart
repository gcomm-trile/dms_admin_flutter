import 'package:dms_admin/modules/visit/visit_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'modules/login/login_binding.dart';
import 'modules/login/login_page.dart';
import 'modules/visit/visit_detail_binding.dart';
import 'modules/visit/visit_detail_page.dart';
import 'modules/visit/visit_page.dart';

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
      initialRoute: '/visitdetail',
      getPages: [
        GetPage(name: '/', page: () => LoginPage(), binding: LoginBinding()),
        GetPage(
            name: '/visit', page: () => VisitPage(), binding: VisitBinding()),
        GetPage(
            name: '/visitdetail',
            page: () => VisitDetailPage(
                visitId: 'c6f7c90e-4c7d-438b-bbab-4c83b3112928'),
            binding: VisitDetailBinding()),
      ],

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

class SecondApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("RectangularIndicator Indicator: stroke"),
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(100)),
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: "Home",
                      ),
                      Tab(
                        text: "Work",
                      ),
                      Tab(
                        text: "Play",
                      ),
                    ],
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: RectangularIndicator(
                      bottomLeftRadius: 100,
                      bottomRightRadius: 100,
                      topLeftRadius: 100,
                      topRightRadius: 100,
                      // paintingStyle: PaintingStyle.stroke,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
