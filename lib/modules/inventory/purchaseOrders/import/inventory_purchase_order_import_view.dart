import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'inventory_purchase_order_import_content_desktop.dart';
import 'inventory_purchase_order_import_content_mobile.dart';

class InventoryPurchaseOrderImportView extends StatelessWidget {
  final id;
  final Function(NavigationCallBackModel data) onNavigationChanged;
  const InventoryPurchaseOrderImportView(
      {Key key, this.onNavigationChanged, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InventoryPurchaseOrderImportContentMobile(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: InventoryPurchaseOrderImportContentDesktop(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
