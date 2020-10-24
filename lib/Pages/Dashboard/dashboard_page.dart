import 'package:dms_admin/Controllers/dashboard_activity_controller.dart';
import 'package:dms_admin/Controllers/dashboard_route_controller.dart';
import 'package:dms_admin/Controllers/dashboard_tonghop_controller.dart';
import 'package:dms_admin/Controllers/dashboard_user_controller.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_activity_page.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_user_page.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_tonghop_page.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_route_page.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  final DashboardTongHopController dashboardTongHopController =
      Get.put(DashboardTongHopController());
  final DashboardRouteController dashboardRouteController =
      Get.put(DashboardRouteController());
  final DashboardUserController dashboardUserController =
      Get.put(DashboardUserController());
  final DashboardActivityController dashboardActivityController =
      Get.put(DashboardActivityController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nestedTabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Báo cáo'),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            _buildSectionRangeDateSection(context),
            SizedBox(height: 10.0),
            PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                    width: 4,
                    color: Color(0xFF646464),
                  )),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.only(left: 0, right: 0),
                  controller: _nestedTabController,
                  labelColor: kPrimaryColor,
                  unselectedLabelColor: Colors.orangeAccent,
                  isScrollable: true,
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                  tabs: <Widget>[
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 100,
                        child: Column(
                          children: [
                            Text('TỔNG HỢP'),
                            Icon(Icons.smart_button_sharp)
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 100,
                        child: Column(
                          children: [Text('TUYẾN'), Icon(Icons.router)],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 100,
                        child: Column(
                          children: [Text('NVBH'), Icon(Icons.person)],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 100,
                        child: Column(
                          children: [Text('HOẠT ĐỘNG'), Icon(Icons.person)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Flexible(
                // height: screenHeight * 0.80,
                // padding: EdgeInsets.all(10.0),
                child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                    DashboardTongHopPage(),
                    DashboardRoutePage(),
                    DashboardUserPage(),
                    DashboardActivityPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSectionRangeDateSection(BuildContext context) => Row(children: [
        Text(
          'Chọn thời gian:',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        MaterialButton(
            color: kPrimaryColor,
            onPressed: () async {
              final List<DateTime> picked = await DateRagePicker.showDatePicker(
                  context: context,
                  initialFirstDate: dashboardTongHopController.startDate.value,
                  initialLastDate: dashboardTongHopController.endDate.value,
                  firstDate: new DateTime(2015),
                  lastDate: new DateTime(2030));
              if (picked != null && picked.length == 2) {
                print(picked);
                dashboardTongHopController.updateDateTimeRange(picked);
                dashboardRouteController.updateDateTimeRange(picked);
                dashboardUserController.updateDateTimeRange(picked);
                dashboardActivityController.updateDateTimeRange(picked);
              }
            },
            child: GetX<DashboardTongHopController>(
              builder: (controller) {
                print('change value');
                return Text(
                  '${DateFormat('dd-MM-yyyy').format(controller.startDate.value)}-> ${DateFormat('dd-MM-yyyy').format(controller.endDate.value)}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            )),
      ]);
}
