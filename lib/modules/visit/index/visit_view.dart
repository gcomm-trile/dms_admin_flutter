import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'visit_content_desktop.dart';
import 'visit_content_mobile.dart';

class VisitsView extends StatelessWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  VisitsView({Key key, @required this.onNavigationChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: VisitContentMobile(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
      tablet: VisitContentDesktop(
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}
