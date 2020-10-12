import 'package:dms_admin/Models/dashboard_tong_hop.dart';
import 'package:dms_admin/Pages/Dashboard/future_generator.dart';
import 'package:flutter/material.dart';

class DashboardTongHopPage extends StatefulWidget {
  final List<DashboardTongHop> data;
  DashboardTongHopPage({Key key, this.data}) : super(key: key);

  @override
  _DashboardTongHopPageState createState() => _DashboardTongHopPageState();
}

class _DashboardTongHopPageState extends State<DashboardTongHopPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container()),
            SizedBox(width: 50.0, child: Text('Thăm viếng')),
            SizedBox(width: 50.0, child: Text('Có đơn hàng')),
            SizedBox(width: 50.0, child: Text('Số đơn hàng')),
            SizedBox(width: 50.0, child: Text('Tổng tiền')),
          ],
        ),
        ListView.builder(
          itemCount: widget.data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                    child: Container(
                  child: Text(
                    widget.data[index].province,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight:
                            index == 0 ? FontWeight.bold : FontWeight.normal),
                  ),
                )),
                SizedBox(
                    width: 50.0,
                    child: Text(widget.data[index].countVisit.toString())),
                SizedBox(
                    width: 50.0,
                    child: Text(widget.data[index].countStoreOrder.toString())),
                SizedBox(
                    width: 50.0,
                    child: Text(widget.data[index].sumOrderPrice.toString())),
              ],
            );
          },
        ),
      ],
    );
  }
}
