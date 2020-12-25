import 'dart:developer';
import 'package:dms_admin/modules/dashboard/dashboard_activity_controller.dart';
import 'package:dms_admin/Models/dashboard_activity.dart';
import 'package:dms_admin/Pages/Store/store_detail_page.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DashboardActivityPage extends StatelessWidget {
  final DashboardActivityController dashboardActivityController =
      Get.put(DashboardActivityController());
  DashboardActivityPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build');

    return GetX<DashboardActivityController>(builder: (controller) {
      return controller.isLoading.value == LoadStatus.loading
          ? Expanded(
              child: Center(
                child: LoadingControl(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  decoration: kBoxDecorationFilter,
                  child: Column(children: [
                    Row(
                      children: [
                        Container(width: 100.0, child: Text('Chọn tỉnh/TP')),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: DropdownButton<String>(
                            value: controller.filterProvince.value,
                            items: controller.provinces
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    width: kWidthDropdown, child: Text(value)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              dashboardActivityController
                                  .setFilterProvince(value);
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(width: 100, child: Text('Chọn NVBH')),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: DropdownButton<String>(
                            value: controller.filterUser.value,
                            items: controller.users
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    width: kWidthDropdown, child: Text(value)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              dashboardActivityController.setFilterUser(value);
                            },
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
                Expanded(
                  child: Container(
                    decoration: kBoxDecorationTable,
                    child: ListView.builder(
                        itemCount: controller.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final example = controller.data[index];
                          return TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            isFirst: index == 0,
                            isLast: index == controller.data.length - 1,
                            indicatorStyle: IndicatorStyle(
                              width: 40,
                              height: 40,
                              indicator:
                                  _IndicatorExample(number: '${index + 1}'),
                              drawGap: true,
                            ),
                            beforeLineStyle: LineStyle(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            endChild: InkWell(
                              child: _RowExample(example: example),
                              onTap: () {
                                _showDialog(context, example);
                              },
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
    });
  }

  _showDialog(BuildContext context, DashboardActivity example) {
    if (example.actionType == 1) {
      log('1');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: StoreDetailPage(
                storeId: example.storeId,
              ),
            );
          });
    }
    if (example.actionType == 2) {
      log(example.visitId);
      // Get.to(VisitDetailPage(visitId: example.visitId),
      //     transition: Transition.zoom, duration: Duration(seconds: 1));
    }
    if (example.actionType == 3) {
      log('3');
    }
  }
}

class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key key, this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 4,
          ),
        ),
      ),
      child: Center(
        child: Text(number,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 26,
            )),
      ),
    );
  }
}

class _RowExample extends StatelessWidget {
  const _RowExample({Key key, this.example}) : super(key: key);

  final DashboardActivity example;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              example.content,
              style: GoogleFonts.jura(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            example.updatedOn,
            style: GoogleFonts.jura(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Divider(
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
