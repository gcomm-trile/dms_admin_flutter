import 'package:dms_admin/Pages/Visit/controller/visit_detail_controller.dart';
import 'package:dms_admin/share/widgets/divider_header.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class VisitCheckOutPage extends StatelessWidget {
  const VisitCheckOutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<VisitDetailController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Phản hồi của cửa hàng'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Text(
              controller.data.value.feedBack,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          Text('Hình ảnh'),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.data.value.checkoutImages.length,
            itemBuilder: (context, index) {
              return Row(children: [
                Image.network(
                  controller.data.value.checkoutImages[index].path,
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
