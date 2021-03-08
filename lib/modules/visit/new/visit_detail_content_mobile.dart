import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/modules/store/store_detail.dart';
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

class VisitDetailContentMobile extends StatelessWidget {
  final String id;
  final Function(NavigationCallBackModel data) onNavigationChanged;

  final VisitDetailController controller = Get.find();
  VisitDetailContentMobile({Key key, this.id, this.onNavigationChanged})
      : super(key: key);

// THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 4; // upperBound MUST BE total number of icons minus 1.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GetX<VisitDetailController>(
          init: controller.getId(id),
          // initState: (state) =>
          //     Get.find<VisitController>().getId(widget.visitId),
          builder: (_) {
            return controller.isBusy.value == true
                ? Center(child: CircularProgressIndicator())
                : tabbarSection();
          }),
    );
  }

  tabbarSection() {
    return Container(
      child: Column(
        children: [
          _headerSection(),
          Container(
            child: infoSection(controller.result.value),
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
            activeStep: controller.activeStep.value,

            // This ensures step-tapping updates the activeStep.
            onStepReached: (index) {
              controller.activeStep.value = index;
            },
          ),
          Expanded(
              child: controller.activeStep.value == 0
                  ? VisitCheckIn()
                  : (controller.activeStep.value == 1
                      ? VisitOrder()
                      : (controller.activeStep.value == 2
                          ? VisitCheckOut()
                          : (controller.activeStep.value == 3
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
                        TextHelper.toSafeString(controller.result.value.no),
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
                        TextHelper.toSafeString(
                            controller.result.value.order.isExportStock == true
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
