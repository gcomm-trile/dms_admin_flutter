import 'package:dms_admin/Controllers/dashboardController.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_tonghop_page.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_tuyen_page.dart';
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
  final DashboardController dashboardController =
      Get.put(DashboardController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _buildSectionRangeDateSection(context),
          TabBar(
            controller: _nestedTabController,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: "TỔNG HỢP",
              ),
              Tab(
                text: "TUYẾN",
              ),
            ],
          ),
          Container(
            child: Flexible(
              // height: screenHeight * 0.80,
              // padding: EdgeInsets.all(10.0),
              child: TabBarView(
                controller: _nestedTabController,
                children: <Widget>[
                  DashboardTongHopPage(),
                  DashboardTuyenPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionRangeDateSection(BuildContext context) => Row(children: [
        Text('Chọn mốc thời gian:'),
        MaterialButton(
            color: Colors.deepOrangeAccent,
            onPressed: () async {
              final List<DateTime> picked = await DateRagePicker.showDatePicker(
                  context: context,
                  initialFirstDate: dashboardController.startDate.value,
                  initialLastDate: dashboardController.endDate.value,
                  firstDate: new DateTime(2015),
                  lastDate: new DateTime(2030));
              if (picked != null && picked.length == 2) {
                print(picked);
                dashboardController.updateDateTimeRange(picked);
              }
            },
            child: GetX<DashboardController>(
              builder: (controller) {
                print('change value');
                return Text(
                    '${DateFormat('dd-MM-yyyy').format(controller.startDate.value)}-> ${DateFormat('dd-MM-yyyy').format(controller.endDate.value)}');
              },
            ))
      ]);
}
