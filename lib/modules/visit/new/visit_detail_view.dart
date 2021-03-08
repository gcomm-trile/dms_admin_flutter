import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/modules/visit/new/visit_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'visit_detail_content_desktop.dart';
import 'visit_detail_content_mobile.dart';

class VisitDetailView extends StatelessWidget {
  final String id;
  final Function(NavigationCallBackModel data) onNavigationChanged;
  VisitDetailController controller = Get.find();
  VisitDetailView(
      {Key key, @required this.onNavigationChanged, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<VisitDetailController>(
      init: controller,
      initState: (state) => controller.getId(id),
      builder: (_) {
        return controller.isBusy.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ScreenTypeLayout(
                mobile: VisitDetailContentDesktop(
                    id: id,
                    onNavigationChanged: (data) => onNavigationChanged(data),
                    controller: controller),
                tablet: VisitDetailContentDesktop(
                  controller: controller,
                  id: id,
                  onNavigationChanged: (data) => onNavigationChanged(data),
                ),
              );
      },
    );
  }
}
