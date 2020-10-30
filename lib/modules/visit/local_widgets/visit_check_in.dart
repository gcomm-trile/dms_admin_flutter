import 'package:dms_admin/modules/visit/visit_detail_controller.dart';
import 'package:dms_admin/share/widgets/divider_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class VisitCheckIn extends StatelessWidget {
  const VisitCheckIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<VisitDetailController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Tình trạng: '),
              Text(
                controller.data.value.isOpened ? 'Mở cửa' : 'Đóng cửa',
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
            itemCount: controller.data.value.checkinImages.length,
            itemBuilder: (context, index) {
              return Row(children: [
                Image.network(
                  controller.data.value.checkinImages[index].path,
                  height: 200,
                  width: 200,
                )
              ]);
            },
          ))
        ],
      );
    });
  }
}
