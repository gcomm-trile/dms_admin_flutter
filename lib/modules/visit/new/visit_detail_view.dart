import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'visit_detail_content_desktop.dart';
import 'visit_detail_content_mobile.dart';

class VisitDetailView extends StatelessWidget {
  final String id;
  final Function(NavigationCallBackModel data) onNavigationChanged;

  VisitDetailView(
      {Key key, @required this.onNavigationChanged, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      // mobile: VisitDetailContentMobile(
      //   id: id,
      //   onNavigationChanged: (data) => onNavigationChanged(data),
      // ),
      tablet: VisitDetailContentDesktop(
        id: id,
        onNavigationChanged: (data) => onNavigationChanged(data),
      ),
    );
  }
}

class VisitDetailContentMobile {}
