import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'inventory_transfers_content_desktop.dart';
import 'inventory_transfers_content_mobile.dart';

class InventoryTransfersView extends StatelessWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;

  InventoryTransfersView({Key key, @required this.onNavigationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InventoryTransfersContentMobile(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: InventoryTransfersContentDesktop(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
