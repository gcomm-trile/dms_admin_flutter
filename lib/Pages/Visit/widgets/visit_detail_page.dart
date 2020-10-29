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
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

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
            : Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        PreferredSize(
                          preferredSize: const Size.fromHeight(
                              30), // const Size.fromHeight(kToolbarHeight),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(100)),
                              child: TabBar(
                                // indicator: UnderlineTabIndicator(
                                //     borderSide: BorderSide(
                                //   width: 4,
                                //   color: Color(0xFF646464),
                                // )),
                                controller: _nestedTabController,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                indicator: RectangularIndicator(
                                  bottomLeftRadius: 100,
                                  bottomRightRadius: 100,
                                  topLeftRadius: 100,
                                  topRightRadius: 100,
                                  // paintingStyle: PaintingStyle.stroke,
                                ),
                                tabs: <Widget>[
                                  Tab(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5),
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text('Check in'),
                                          // Icon(Icons.smart_button_sharp)
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
                                          // Icon(Icons.router)
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
                                          // Icon(Icons.person)
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
                                          // Icon(Icons.person)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Flexible(
                            // height: screenHeight * 0.80,
                            // padding: EdgeInsets.all(10.0),
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
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
                  ),
                ],
              );
      }),
    );
  }
}
