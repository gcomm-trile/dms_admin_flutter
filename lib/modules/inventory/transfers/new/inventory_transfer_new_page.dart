import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'inventory_transfer_new_content_desktop.dart';
import 'inventory_transfer_new_content_mobile.dart';


class InventoryTransferNewView extends StatelessWidget {
 final id;
  final Function(NavigationCallBackModel data) onNavigationChanged;

  InventoryTransferNewView(
      {Key key, @required this.id, @required this.onNavigationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InventoryTransferNewContentMobile(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: InventoryTransferNewContentDesktop(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
