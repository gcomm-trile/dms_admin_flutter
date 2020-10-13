import 'package:dms_admin/Controllers/dashboardController.dart';
import 'package:dms_admin/Models/dashboard_tong_hop.dart';
import 'package:dms_admin/Pages/Dashboard/future_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTongHopPage extends StatelessWidget {
  const DashboardTongHopPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build tong hop');
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container()),
            SizedBox(width: 50.0, child: Text('Thăm viếng')),
            SizedBox(width: 50.0, child: Text('Có đơn hàng')),
            SizedBox(width: 50.0, child: Text('Số đơn hàng')),
            SizedBox(width: 50.0, child: Text('Tổng tiền')),
          ],
        ),
        GetX<DashboardController>(builder: (controller) {
          return controller.isLoading.value
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: controller.report.value.reportTonghop.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Text(
                              controller
                                  .report.value.reportTonghop[index].province,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: index == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          )),
                          SizedBox(
                              width: 50.0,
                              child: Text(controller
                                  .report.value.reportTonghop[index].countVisit
                                  .toString())),
                          SizedBox(
                              width: 50.0,
                              child: Text(controller.report.value
                                  .reportTonghop[index].countStoreOrder
                                  .toString())),
                          SizedBox(
                              width: 50.0,
                              child: Text(controller
                                  .report.value.reportTonghop[index].countOrder
                                  .toString())),
                          SizedBox(
                              width: 50.0,
                              child: Text(controller.report.value
                                  .reportTonghop[index].sumOrderPrice
                                  .toString())),
                        ],
                      );
                    },
                  ),
                );
        }),
      ],
    );
  }
}
