import 'package:dms_admin/Pages/Visit/controller/visit_controller.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/share/load_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitPage extends StatelessWidget {
  const VisitPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Visit'),
        ),
        body: GetX<VisitController>(
          init: VisitController(),
          builder: (controller) {
            return controller.isLoading.value == LoadStatus.success
                ? ListView.builder(
                    itemCount: controller.data.value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Center(
                              child: Text('abc'),
                            ),
                            Column(
                              children: [
                                Text('c1'),
                                Text('c2'),
                                Text('c3'),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
                : LoadingControl();
          },
        ));
  }
}
