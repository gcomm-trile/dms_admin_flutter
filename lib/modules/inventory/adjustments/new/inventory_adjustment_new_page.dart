import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/modules/inventory/adjustments/new/inventory_adjustment_new_desktop_page.dart';
import 'package:dms_admin/modules/inventory/adjustments/new/inventory_adjustment_new_mobile_page.dart';
import 'package:dms_admin/utils/device_screene_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inventory_adjustment_new_controller.dart';

class InventoryAdjustmentNewPage extends StatelessWidget {
  final id;
  final DeviceScreenType deviceScreenType;
  final Function(NavigationCallBackModel data) onNavigationChanged;
  final InventoryAdjustmentNewController controller = Get.find();
  InventoryAdjustmentNewPage(
      {Key key,
      @required this.id,
      @required this.deviceScreenType,
      @required this.onNavigationChanged})
      : super(key: key);
  Widget build(BuildContext context) {
    return deviceScreenType == DeviceScreenType.mobile
        ? InventoryAdjustmentNewMobilePage(
            id: id,
            onNavigationChanged: (data) => onNavigationChanged(data),
          )
        : InventoryAdjustmentNewDesktopPage(
            id: id,
            onNavigationChanged: (data) => onNavigationChanged(data),
          );
  }
}
