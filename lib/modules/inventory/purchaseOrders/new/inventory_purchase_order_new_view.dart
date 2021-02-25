import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/modules/inventory/purchaseOrders/new/inventory_purchase_order_new_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'inventory_purchase_order_new_content_desktop.dart';
import 'inventory_purchase_order_new_content_mobile.dart';

class InventoryPurchaseOrderNewView extends StatelessWidget {
  final sizedBox = SizedBox(
    width: 10,
  );
  final purchaseOrderId;
  final InventoryPurchaseOrderNewController controller =
      InventoryPurchaseOrderNewController(repository: Get.find());

  final Function(NavigationCallBackModel data) onNavigationChanged;

  InventoryPurchaseOrderNewView(
      {Key key,
      @required this.purchaseOrderId,
      @required this.onNavigationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InventoryPurchaseOrderNewContentMobile(
        purchaseOrderId: purchaseOrderId,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: InventoryPurchaseOrderNewContentDesktop(
        purchaseOrderId: purchaseOrderId,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
