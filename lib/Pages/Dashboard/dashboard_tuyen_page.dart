import 'package:dms_admin/Controllers/dashboardController.dart';
import 'package:dms_admin/Models/dashboard.dart';
import 'package:dms_admin/Models/dashboard_tong_hop.dart';
import 'package:dms_admin/Pages/Dashboard/future_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTuyenPage extends StatelessWidget {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  DashboardTuyenPage({Key key}) : super(key: key);

  Widget get _buildFilterTuyen => Row(
        children: [Text('Chọn tuyến')],
      );

  @override
  Widget build(BuildContext context) {
    print('build tuyen');

    return GetX<DashboardController>(builder: (controller) {
      return controller.isLoading.value
          ? Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(children: [
              Row(
                children: [
                  Text('Chọn tỉnh/TP'),
                  Container(
                    child: DropdownButton<String>(
                      value: controller.filter_city.value,
                      items: controller.report.value.provinces
                          .map<DropdownMenuItem<String>>((Provinces value) {
                        return DropdownMenuItem<String>(
                          value: value.province,
                          child: Text(value.province),
                        );
                      }).toList(),
                      onChanged: (value) {
                        dashboardController.setFilterCity(value);
                      },
                    ),
                  )
                ],
              ),
              _buildFilterTuyen,
              Row(
                children: [
                  Expanded(child: Container()),
                  SizedBox(width: 50.0, child: Text('Thăm viếng')),
                  SizedBox(width: 50.0, child: Text('Có đơn hàng')),
                  SizedBox(width: 50.0, child: Text('Số đơn hàng')),
                  SizedBox(width: 50.0, child: Text('Tổng tiền')),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: controller.report.value.reportTonghop.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildRowListView(
                          controller.report.value.reportTonghop[index]);
                    }),
              ),
            ]);
    });
  }

  Widget _buildRowListView(ReportTonghop item) {
    return Row(
      children: [
        Expanded(
            child: Container(
          child: Text(
            item.province,
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
