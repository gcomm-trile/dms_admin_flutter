import 'package:flutter/material.dart';

import 'drawer.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  static const String routeName = "/dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        drawer: AppDrawer(),
        body: Column(children: [Text("Chọn ngày")]));
  }
}
