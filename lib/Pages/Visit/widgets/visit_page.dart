import 'package:dms_admin/Models/visit.dart';
import 'package:dms_admin/Pages/Visit/controller/visit_controller.dart';
import 'package:dms_admin/Pages/Visit/widgets/visit_detail_page.dart';
import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/constants.dart';
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
          title: Text('Viếng thăm'),
        ),
        body: GetX<VisitController>(
          init: VisitController(),
          builder: (controller) {
            return controller.isLoading.value == LoadStatus.success
                ? ListView.builder(
                    itemCount: controller.data.value.length,
                    itemBuilder: (context, index) {
                      return _buildRowListViewSection(
                          controller.data.value[index]);
                    },
                  )
                : LoadingControl();
          },
        ));
  }

  Widget _buildRowListViewSection(Visit item) {
    return InkWell(
        onTap: () {
          Get.to(
              VisitDetailPage(
                visitId: item.id,
              ),
              transition: Transition.downToUp);
        },
        child: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0)),
                height: 100,
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(5.0),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryLightColor, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Text(
                            item.seq == null ? 'N/A' : item.seq,
                            style:
                                TextStyle(color: Colors.black, fontSize: 25.0),
                          ),
                        )),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.store),
                                  Flexible(
                                    child: Text(item.storeName),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  Flexible(
                                    child: Text(item.userName),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.timer),
                                  Flexible(
                                    child: Text(item.createdOn),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
