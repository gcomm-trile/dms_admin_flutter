import 'package:dms_admin/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

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
  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
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
        Tab(
          text: "TUYẾN",
        ),
        Tab(
          text: "NHÂN VIÊN",
        ),
        Tab(
          text: "HOẠT ĐỘNG",
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('abc'),
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.orange,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "Inside Pokhara",
            ),
            Tab(
              text: "Outside Pokhara",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
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
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTabSection() {
    return Column(children: [_buildTabBarSection, _buildTabViewSection()]);
  }
}
