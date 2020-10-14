import 'package:dms_admin/Controllers/dashboard_route_controller.dart';
import 'package:dms_admin/Models/dashboard_route.dart';
import 'package:dms_admin/Pages/Dashboard/listview_header.dart';
import 'package:dms_admin/Pages/Dashboard/listview_row.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/constants.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:dms_admin/share/widgets/divider_header.dart';
import 'package:dms_admin/share/widgets/divider_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardRoutePage extends StatelessWidget {
  final DashboardRouteController dashboardTuyenController =
      Get.put(DashboardRouteController());
  DashboardRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build tuyen');

    return GetX<DashboardRouteController>(builder: (controller) {
      return controller.isLoading.value == LoadStatus.loading
          ? Expanded(
              child: Center(
                child: LoadingControl(),
              ),
            )
          : Column(children: [
              SizedBox(
                height: 5.0,
              ),
             
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(children: [
                      Row(
                        children: [
                          Container(width: 100.0, child: Text('Chọn tỉnh/TP')),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: DropdownButton<String>(
                              value: controller.filterProvince.value,
                              items: controller.provinces
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width: kWidthDropdown,
                                      child: Text(value)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                dashboardTuyenController
                                    .setFilterProvince(value);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 100, child: Text('Chọn tuyến')),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: DropdownButton<String>(
                              value: controller.filterRoute.value,
                              items: controller.routes
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width: kWidthDropdown,
                                      child: Text(value)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                dashboardTuyenController.setFilterRoute(value);
                              },
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                  Positioned(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Colors.white,
                        child: Text(
                          'Bộ lọc',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                    left: 30.0,
                    top: 0.0,
                  )
                ],
              ),
              DividerHeader(),
              ListViewHeader(),
              DividerHeader(),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return DividerRow();
                    },
                    itemCount: controller.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListViewRow(
                        content: controller.data[index].routeName,
                        countOrder: controller.data[index].countOrder,
                        countStoreOrder: controller.data[index].countStoreOrder,
                        countVisit: controller.data[index].countVisit,
                        sumOrderPrice: controller.data[index].sumOrderPrice,
                      );
                    }),
              ),
            ]);
    });
  }

  Widget _buildRowListView(DashboardRoute item) {
    return Row(
      children: [
        Expanded(
            child: Container(
          child: Text(
            item.routeName,
          ),
        )),
        SizedBox(width: 50.0, child: Text(item.countVisit.toString())),
        SizedBox(width: 50.0, child: Text(item.countStoreOrder.toString())),
        SizedBox(width: 50.0, child: Text(item.countOrder.toString())),
        SizedBox(width: 50.0, child: Text(item.sumOrderPrice.toString())),
      ],
    );
  }
}
