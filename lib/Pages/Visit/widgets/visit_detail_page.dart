import 'package:dms_admin/Pages/Visit/controller/visit_detail_controller.dart';
import 'package:dms_admin/Pages/Visit/widgets/visit_check_in_page.dart';
import 'package:dms_admin/Pages/Visit/widgets/visit_check_out_page.dart';
import 'package:dms_admin/Pages/Visit/widgets/visit_map_page.dart';
import 'package:dms_admin/Pages/Visit/widgets/visit_order_page.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/constants.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitDetailPage extends StatefulWidget {
  final String visitId;

  VisitDetailPage({Key key, this.visitId}) : super(key: key);

  @override
  _VisitDetailPageState createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  final VisitDetailController visitDetailController =
      Get.put(VisitDetailController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nestedTabController = new TabController(length: 4, vsync: this);
    visitDetailController.setVisitId(widget.visitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết viếng thăm'),
      ),
      body: GetX<VisitDetailController>(builder: (controller) {
        return controller.isLoading.value == LoadStatus.loading
            ? LoadingControl()
            : Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
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
                                    Text('Check in'),
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
                                  children: [
                                    Text('Đơn hàng'),
                                    Icon(Icons.router)
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.only(top: 5),
                                width: 100,
                                child: Column(
                                  children: [
                                    Text('Check out'),
                                    Icon(Icons.person)
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.only(top: 5),
                                width: 100,
                                child: Column(
                                  children: [
                                    Text('Bản đồ'),
                                    Icon(Icons.person)
                                  ],
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
                            VisitCheckInPage(),
                            VisitOrderDetailPage(order_id: widget.visitId),
                            VisitCheckOutPage(),
                            VisitMapPage(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
