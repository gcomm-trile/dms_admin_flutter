import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'inventory_purchase_orders_content_desktop.dart';
import 'inventory_purchase_orders_content_mobile.dart';
import 'inventory_purchase_orders_controller.dart';

class InventoryPurchaseOrdersView extends StatelessWidget {
  final InventoryPurchaseOrdersController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;

  InventoryPurchaseOrdersView({Key key, @required this.onNavigationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return ScreenTypeLayout(
      mobile: InventoryPurchaseOrdersContentMobile(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: InventoryPurchaseOrdersContentDesktop(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
