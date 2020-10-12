import 'dart:developer';
import 'dart:math';

import 'package:dms_admin/Models/dashboard_tong_hop.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_tonghop_page.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../Data/api_helper.dart';
import '../../Data/api_helper.dart';
import '../../Models/product.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  DateTimeRange range = new DateTimeRange(
      start: DateTime.now().add(new Duration(days: -7)), end: DateTime.now());

  Future<List<DashboardTongHop>> dashboardTongHop;
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 1, vsync: this);
    dashboardTongHop = API_HELPER.getReportTongHop();
    // products = API_HELPER.getProductStream();
  }

  get _buildSectionRangeDateSection => Row(children: [
        Text('Chọn mốc thời gian:'),
        MaterialButton(
            color: Colors.deepOrangeAccent,
            onPressed: () async {
              final List<DateTime> picked = await DateRagePicker.showDatePicker(
                  context: context,
                  initialFirstDate: new DateTime.now(),
                  initialLastDate:
                      (new DateTime.now()).add(new Duration(days: 7)),
                  firstDate: new DateTime(2015),
                  lastDate: new DateTime(2021));
              if (picked != null && picked.length == 2) {
                setState(() {
                  range =
                      new DateTimeRange(start: picked.first, end: picked.last);
                });
                print(picked);
              }
            },
            child: new Text(
                '${DateFormat('dd-MM-yyyy').format(range.start)}-> ${DateFormat('dd-MM-yyyy').format(range.end)}'))
      ]);

  _buildBodySection(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_buildSectionRangeDateSection, _buildTabSection()],
      ),
    );
  }

  TabBar get _buildTabBarSection {
    return TabBar(
      controller: _nestedTabController,
      indicatorColor: Colors.orange,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.black54,
      isScrollable: true,
      tabs: <Widget>[
        Tab(
          text: "TỔNG HỢP",
        ),
      ],
    );
  }

  Widget _buildTabViewSection() {
    return TabBarView(controller: _nestedTabController, children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blueGrey[300],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blueGrey[300],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.red[300],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.yellow[300],
        ),
      )
    ]);
  }

  Widget get _buildDashboardTongHop {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.blueGrey[300],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                SizedBox(width: 50.0, child: Text('Thăm viếng')),
                SizedBox(width: 50.0, child: Text('Có đơn hàng')),
                SizedBox(width: 50.0, child: Text('Số đơn hàng')),
                SizedBox(width: 50.0, child: Text('Tổng tiền')),
              ],
            ),
            Expanded(
                child: FutureBuilder<List<DashboardTongHop>>(
              future: dashboardTongHop,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Text(
                              snapshot.data[index].province,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: index == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          )),
                          SizedBox(
                              width: 50.0,
                              child: Text(
                                  snapshot.data[index].countVisit.toString())),
                          SizedBox(
                              width: 50.0,
                              child: Text(snapshot.data[index].countStoreOrder
                                  .toString())),
                          SizedBox(
                              width: 50.0,
                              child: Text(snapshot.data[index].sumOrderPrice
                                  .toString())),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          _buildSectionRangeDateSection,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<DashboardTongHop>> _generateRandomInt() {
    return API_HELPER.getReportTongHop();
  }

  Widget _buildTabSection() {
    return Column(children: [_buildTabBarSection, _buildTabViewSection()]);
  }

  void refreshData() {}
}
