import 'package:dms_admin/modules/visit/new/visit_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitCheckOut extends GetView<VisitDetailController> {
  const VisitCheckOut({Key key}) : super(key: key);
  // final VisitDetailController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    print('build visit check out');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phản hồi của cửa hàng'),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(
            controller.result.value.feedBack,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Text('Hình ảnh'),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.result.value.checkoutImages.length,
          itemBuilder: (context, index) {
            return Row(children: [
              Image.network(
                controller.result.value.checkoutImages[index].path,
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
