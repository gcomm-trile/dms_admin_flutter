import 'package:dms_admin/data/model/store.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/widgets/icon_text.dart';
import 'package:flutter/material.dart';

class StoreDetail extends StatelessWidget {
  final Store store;
  const StoreDetail({
    Key key,
    @required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Thông tin cửa hàng', style: kStyleListViewHeader),
          SizedBox(
            height: 10,
          ),
          IconText(
            icon: Icons.store,
            text: store.name,
          ),
          IconText(
            icon: Icons.phone,
            text: store.phone,
          ),
          IconText(
              icon: Icons.gps_fixed,
              text: store.address +
                  ', ' +
                  store.ward +
                  ' ,' +
                  store.district +
                  ', ' +
                  store.province),
          IconText(
            icon: Icons.person,
            text: store.owner,
          ),
        ],
      ),
    );
  }
}
