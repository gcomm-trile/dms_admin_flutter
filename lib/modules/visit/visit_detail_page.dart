import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/modules/store/store_detail.dart';
import 'package:dms_admin/modules/visit/local_widgets/tab_header.dart';
import 'package:dms_admin/modules/visit/local_widgets/visit_order.dart';
import 'package:dms_admin/modules/visit/visit_detail_controller.dart';

import 'package:dms_admin/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
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
        body: bodySection());
  }

  bodySection() {
    // return Text('abc');
    return GetX<VisitDetailController>(
        initState: (state) =>
            Get.find<VisitDetailController>().getId(widget.visitId),
        builder: (controller) {
          return controller.visit.id == null
              ? Center(child: CircularProgressIndicator())
              : mainBodySection(controller.visit);
        });
  }

  tabbarSection(Visit visit) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: TabBar(
        controller: _nestedTabController,
        // indicatorColor: Colors.black,
        // labelColor: Colors.black,

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
          TabHeader(title: 'Check in'),
          TabHeader(title: 'Đơn hàng'),
          TabHeader(title: 'Check out'),
          TabHeader(title: 'Bản đồ'),
        ],
      ),
    );
  }

  mainBodySection(Visit data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
                pinned: false,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      infoSection(data),
                    ],
                  ),
                ),
                expandedHeight: 155,
                bottom: tabbarSection(data))
          ];
        },
        body: Column(
          children: [
            Flexible(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _nestedTabController,
                children: <Widget>[
                  const VisitCheckIn(),
                  VisitOrder(),
                  const VisitCheckOut(),
                  const VisitMap(),
                ],
              ),
            )
          ],
        ),
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
              child: IconText(icon: Icons.store, text: visit.store.name)),
          IconText(icon: Icons.person, text: visit.createdByName),
          IconText(icon: Icons.timer, text: visit.createdOn),
        ],
      ),
    );
  }
}
