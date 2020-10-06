import 'dart:developer';

import 'package:dms_admin/Models/stock.dart';
import 'package:dms_admin/Pages/Stock/stock_countproduct_page.dart';
import 'package:dms_admin/Pages/Stock/stock_decrease_page.dart';
import 'package:dms_admin/Pages/Stock/stock_increase_page.dart';
import 'package:dms_admin/Pages/Stock/stock_info_page.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class StockDetailPage extends StatelessWidget {
  final Stock data;
  StockDetailPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: KeyboardDismisser(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Thông tin kho"),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.info_outline),
                  text: "Thông tin",
                ),
                Tab(
                  icon: Icon(Icons.inventory),
                  text: "Tồn",
                ),
                Tab(
                  icon: Icon(Icons.call_received),
                  text: "Nhập",
                ),
                Tab(
                  icon: Icon(Icons.call_made),
                  text: "Xuất",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StockInfoPage(data),
              StockCountProductPage(
                stock_id: data.id,
              ),
              StockIncreasePage(stockId: data.id),
              StockDecreasePage(stockId: data.id),
            ],
          ),
        ),
      ),
    );
  }
}
