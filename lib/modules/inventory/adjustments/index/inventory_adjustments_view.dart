import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'inventory_adjustments_content_desktop.dart';
import 'inventory_adjustments_content_mobile.dart';
import 'inventory_adjustments_controller.dart';

class InventoryAdjustmentsView extends StatelessWidget {
  final InventoryAdjustmentsController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;

  InventoryAdjustmentsView({Key key, @required this.onNavigationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InventoryAdjustmentsContentMobile(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: InventoryAdjustmentsContentDesktop(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
