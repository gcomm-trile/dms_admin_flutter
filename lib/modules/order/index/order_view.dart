import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/modules/order/index/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'order_content_desktop.dart';
import 'order_content_mobile.dart';

class OrdersView extends StatelessWidget {
  final OrderController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;

  OrdersView({Key key, @required this.onNavigationChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrderContentMobile(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: OrderContentDesktop(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
