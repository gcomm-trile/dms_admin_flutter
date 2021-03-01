import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'inventory_transfer_import_content_desktop.dart';
import 'inventory_transfer_import_content_mobile.dart';
import 'inventory_transfer_import_controller.dart';

class InventoryTransferImportView extends StatelessWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  final id;

  final InventoryTransferImportController controller =
      InventoryTransferImportController(repository: Get.find());

  InventoryTransferImportView({Key key, this.onNavigationChanged, this.id})
      : super(key: key);

  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InventoryTransferImportContentMobile(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: InventoryTransferImportContentDesktop(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
