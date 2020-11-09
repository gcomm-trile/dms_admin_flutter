import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/modules/store/store_detail.dart';
import 'package:dms_admin/modules/visit/local_widgets/tab_header.dart';
import 'package:dms_admin/modules/visit/local_widgets/visit_order.dart';
import 'package:dms_admin/modules/visit/visit_controller.dart';
import 'package:dms_admin/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'local_widgets/visit_check_in.dart';
import 'local_widgets/visit_check_out.dart';
import 'local_widgets/visit_map.dart';

class VisitDetailPage extends StatefulWidget {
  final String visitId;

  VisitDetailPage({Key key, this.visitId}) : super(key: key);

  @override
  _VisitDetailPageState createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết viếng thăm'),
        ),
        body: GetX<VisitController>(
            init: Get.find<VisitController>().getId(widget.visitId),
            // initState: (state) =>
            //     Get.find<VisitController>().getId(widget.visitId),
            builder: (controller) {
              return controller.visit.id == null
                  ? Center(child: CircularProgressIndicator())
                  : mainBodySection(controller.visit);
            }));
  }

  tabbarSection(Visit visit) {
    return PreferredSize(
      preferredSize: Size.fromHeight(20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 0, right: 0),
          // labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
          controller: _nestedTabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: RectangularIndicator(
            bottomLeftRadius: 15,
            bottomRightRadius: 15,
            topLeftRadius: 15,
            topRightRadius: 15,
            // paintingStyle: PaintingStyle.stroke,
          ),
          tabs: <Widget>[
            // Tab(icon: Icon(Icons.directions_car)),
            // Tab(icon: Icon(Icons.directions_transit)),
            // Tab(icon: Icon(Icons.directions_bike)),
            // Tab(icon: Icon(Icons.directions_bike)),
            TabHeader(title: 'Check in'),
            TabHeader(title: 'Đơn hàng'),
            TabHeader(title: 'Check out'),
            TabHeader(title: 'Bản đồ'),
          ],
        ),
      ),
    );
  }

  mainBodySection(Visit data) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          infoSection(data),
          SizedBox(
            height: 10.0,
          ),
          tabbarSection(data),
          Flexible(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _nestedTabController,
              children: <Widget>[
                Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(),
                    //     borderRadius: BorderRadius.circular(2.5)),
                    margin: EdgeInsets.all(5),
                    child: const VisitCheckIn()),
                Container(
                    padding: EdgeInsets.all(5), child: const VisitOrder()),
                Container(
                    padding: EdgeInsets.all(5), child: const VisitCheckOut()),
                Container(padding: EdgeInsets.all(5), child: const VisitMap()),
              ],
            ),
          )
        ],
      ),
    );
  }

  infoSection(Visit visit) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.bottomSheet(StoreDetail(store: visit.store),
                  backgroundColor: Colors.white, shape: Border.all());
            },
            child: Row(
              children: [
                Icon(Icons.store),
                Text(visit.store.name),
                SizedBox(
                  width: 10.0,
                ),
                Icon(Icons.phone),
                Text(visit.store.phone),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.person),
              Text(visit.createdByName),
              SizedBox(
                width: 10.0,
              ),
              Icon(Icons.timer),
              Text(visit.createdOn),
            ],
          ),
          // IconText(icon: Icons.person, text: visit.createdByName),
          // IconText(icon: Icons.timer, text: visit.createdOn),
        ],
      ),
    );
  }
}
