import 'package:flutter/material.dart';
import 'package:dms_admin/modules/visit/visit_detail_controller.dart';
import 'package:get/get.dart';

class VisitCheckIn extends GetView<VisitDetailController> {
  const VisitCheckIn({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('build visit check in');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Tình trạng: '),
            Text(
              controller.visit.isOpened ? 'Mở cửa' : 'Đóng cửa',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Text('Hình ảnh'),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.visit.checkinImages != null
              ? controller.visit.checkinImages.length
              : 0,
          itemBuilder: (context, index) {
            return Row(children: [
              Image.network(
                controller.visit.checkinImages[index].path,
                height: 200,
                width: 200,
              )
            ]);
          },
        ))
      ],
    );
  }
}
