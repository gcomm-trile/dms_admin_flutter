import 'package:dms_admin/components/drawer.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/modules/visit/visit_binding.dart';
import 'package:dms_admin/modules/visit/visit_controller.dart';
import 'package:dms_admin/modules/visit/visit_detail_page.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitPage extends GetView<VisitController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Viếng thăm')),
      drawer: AppDrawer(),
      body: GetX<VisitController>(
        initState: (state) {
          Get.find<VisitController>().getAll();
        },
        builder: (_) {
          return _.visitList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        height: 1,
                      ),
                  itemCount: _.visitList.length,
                  itemBuilder: (context, index) {
                    return _buildRowListViewSection(_.visitList[index]);
                  });
        },
      ),
    );
  }

  Widget _buildRowListViewSection(Visit item) {
    return InkWell(
        onTap: () {
          Get.to(
              VisitDetailPage(
                visitId: item.id,
              ),
              binding: VisitBinding(),
              transition: Transition.downToUp);
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
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
                                    child: Text(item.createdByName),
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
