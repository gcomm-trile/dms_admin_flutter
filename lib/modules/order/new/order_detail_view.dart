import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/modules/order/index/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'order_detail_content_desktop.dart';
import 'order_detail_content_mobile.dart';

class OrderDetailView extends StatelessWidget {
  final String id;
  final OrderController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;

  OrderDetailView(
      {Key key, @required this.onNavigationChanged, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrderDetailContentMobile(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: OrderDetailContentDesktop(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
