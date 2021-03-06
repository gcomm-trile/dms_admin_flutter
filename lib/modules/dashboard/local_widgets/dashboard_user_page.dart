import 'package:dms_admin/modules/dashboard/dashboard_user_controller.dart';

import 'package:dms_admin/modules/dashboard/local_widgets/listview_header.dart';
import 'package:dms_admin/modules/dashboard/local_widgets/listview_row.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:dms_admin/share/widgets/divider_header.dart';
import 'package:dms_admin/share/widgets/divider_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardUserPage extends StatelessWidget {
  final DashboardUserController dashboardTuyenController =
      Get.put(DashboardUserController());
  DashboardUserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build nvbh');

    return GetX<DashboardUserController>(builder: (controller) {
      return controller.isLoading.value == LoadStatus.loading
          ? Column(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: LoadingControl(),
                    ),
                  ),
                )
              ],
            )
          : Column(children: [
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: kBoxDecorationFilter,
                child: Column(children: [
                  Row(
                    children: [
                      Container(width: 100, child: Text('Chọn tỉnh/TP')),
                      Container(
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
                            dashboardTuyenController.setFilterProvince(value);
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(width: 100, child: Text('Chọn tuyến')),
                      Container(
                        child: DropdownButton<String>(
                          value: controller.filterRoute.value,
                          items: controller.routes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                  width: kWidthDropdown, child: Text(value)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            dashboardTuyenController.setFilterRoute(value);
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(width: 100, child: Text('Chọn NVBH')),
                      Container(
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
                            dashboardTuyenController.setFilterUser(value);
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
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        if (index == 0) return DividerHeader();
                        return DividerRow();
                      },
                      itemCount: controller.data.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == 0) return ListViewHeader();
                        return ListViewRow(
                          content: controller.data[index - 1].reportDate
                              .replaceAll('T00:00:00', ''),
                          countOrder: controller.data[index - 1].countOrder,
                          countStoreOrder:
                              controller.data[index - 1].countStoreOrder,
                          countVisit: controller.data[index - 1].countVisit,
                          sumOrderPrice:
                              controller.data[index - 1].sumOrderPrice,
                        );
                      }),
                ),
              ),
            ]);
    });
  }

  
}
