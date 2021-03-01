import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/modules/store/store_detail.dart';
import 'package:dms_admin/modules/visit/local_widgets/tab_header.dart';
import 'package:dms_admin/modules/visit/local_widgets/visit_order.dart';
import 'package:dms_admin/modules/visit/new/visit_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../local_widgets/visit_check_in.dart';
import '../local_widgets/visit_check_out.dart';
import '../local_widgets/visit_map.dart';

class VisitDetailContentDesktop extends StatefulWidget {
  final String id;
  final Function(NavigationCallBackModel data) onNavigationChanged;
  final VisitDetailController controller = Get.find();

  VisitDetailContentDesktop({Key key, this.id, this.onNavigationChanged})
      : super(key: key);

  @override
  _VisitDetailContentDesktopState createState() =>
      _VisitDetailContentDesktopState();
}

class _VisitDetailContentDesktopState extends State<VisitDetailContentDesktop>
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
    return GetX<VisitDetailController>(
        init: widget.controller.getId(widget.id),
        // initState: (state) =>
        //     Get.find<VisitController>().getId(widget.visitId),
        builder: (_) {
          return widget.controller.isBusy.value == true
              ? Center(child: CircularProgressIndicator())
              : mainBodySection(widget.controller.result.value);
        });
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
                    margin: EdgeInsets.all(5), child: const VisitCheckIn()),
                Container(
                  padding: EdgeInsets.all(5),
                  child: const VisitOrder(),
                ),
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
