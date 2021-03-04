import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'content_desktop.dart';

class DashboardView extends StatelessWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  DashboardView({Key key, @required this.onNavigationChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ContentDesktop(
        onNavigationChanged: (NavigationCallBackModel data) {},
      ),
      tablet: ContentDesktop(
        onNavigationChanged: (NavigationCallBackModel data) {},
      ),
    );
  }
}
