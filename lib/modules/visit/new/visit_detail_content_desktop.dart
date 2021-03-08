import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/modules/store/store_detail.dart';
import 'package:dms_admin/modules/visit/local_widgets/tab_header.dart';
import 'package:dms_admin/modules/visit/local_widgets/visit_order.dart';
import 'package:dms_admin/modules/visit/new/visit_detail_controller.dart';
import 'package:dms_admin/utils/color_helper.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import '../local_widgets/visit_check_in.dart';
import '../local_widgets/visit_check_out.dart';
import '../local_widgets/visit_map.dart';

class VisitDetailContentDesktop extends StatefulWidget {
  final String id;
  final Function(NavigationCallBackModel data) onNavigationChanged;

  final VisitDetailController controller;
  VisitDetailContentDesktop(
      {Key key, this.id, this.onNavigationChanged, this.controller})
      : super(key: key);

  @override
  _VisitDetailContentDesktopState createState() =>
      _VisitDetailContentDesktopState();
}

class _VisitDetailContentDesktopState extends State<VisitDetailContentDesktop> {
// THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 4; // upperBound MUST BE total number of icons minus 1.
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10), child: tabbarSection());
  }

  tabbarSection() {
    return Container(
      child: Column(
        children: [
          _headerSection(),
          Container(
            child: infoSection(widget.controller.result.value),
          ),
          IconStepper(
            icons: [
              Icon(Icons.supervised_user_circle),
              Icon(Icons.flag),
              Icon(Icons.access_alarm),
              Icon(Icons.map),
            ],
            enableNextPreviousButtons: false,
            // activeStep property set to activeStep variable defined above.
            activeStep: activeStep,

            // This ensures step-tapping updates the activeStep.
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              });
            },
          ),
          Expanded(
              child: activeStep == 0
                  ? VisitCheckIn()
                  : (activeStep == 1
                      ? VisitOrder()
                      : (activeStep == 2
                          ? VisitCheckOut()
                          : (activeStep == 3
                              ? VisitMap()
                              : Container(color: Colors.red)))))
        ],
      ),
    );
  }

  _headerSection() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      'MÃ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 25,
                      child: Text(
                        TextHelper.toSafeString(
                            widget.controller.result.value.no),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRẠNG THÁI',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: ColorHelper.fromHex("#e8ae0e"),
                      ),
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        TextHelper.toSafeString(widget.controller.result.value
                                    .order.isExportStock ==
                                true
                            ? 'Đã xuất'
                            : 'Chưa xuất'),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
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
              Text(DateTimeHelper.day2Text(visit.createdOn)),
            ],
          ),
          // IconText(icon: Icons.person, text: visit.createdByName),
          // IconText(icon: Icons.timer, text: visit.createdOn),
        ],
      ),
    );
  }
}
