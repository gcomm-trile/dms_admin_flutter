import 'package:dms_admin/modules/dashboard/dashboard_tonghop_controller.dart';
import 'package:dms_admin/modules/dashboard/local_widgets/listview_header.dart';
import 'package:dms_admin/modules/dashboard/local_widgets/listview_row.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/share/widgets/divider_header.dart';
import 'package:dms_admin/share/widgets/divider_row.dart';
import 'package:intl/intl.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTongHopPage extends StatelessWidget {
  DashboardTongHopPage({Key key}) : super(key: key);
  final formatNumber = new NumberFormat('#,###,###,###', 'en_US');

  @override
  Widget build(BuildContext context) {
    print('build tong hop');
    return GetX<DashboardTongHopController>(builder: (controller) {
      return controller.isLoading.value == LoadStatus.loading
          ? Column(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            )
          : Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
              decoration: kBoxDecorationTable,
              child: Column(
                children: [
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
                          content: controller.data[index].province,
                          countOrder: controller.data[index].countOrder,
                          countStoreOrder:
                              controller.data[index].countStoreOrder,
                          countVisit: controller.data[index].countVisit,
                          sumOrderPrice: controller.data[index].sumOrderPrice,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
    });
  }
}
