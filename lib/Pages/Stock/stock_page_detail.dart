import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/stock.dart';
import 'package:dms_admin/components/my_checkbox.dart';
import 'package:dms_admin/components/my_textfield.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class StockDetailPage extends StatelessWidget {
  StockDetailPage(this.data, {Key key}) : super(key: key);
  final Stock data;
  TextEditingController _noController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  FToast fToast;

  @override
  Widget build(BuildContext context) {
    _noController.text = data.no;
    _nameController.text = data.name;

    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                _headerSection,
                _noSection,
                _nameSection,
                _activeSection,
                _updateButtonSection(context)
              ],
            )));
  }

  Widget get _headerSection {
    return Text(
      "THÔNG TIN KHO",
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  Widget _updateButtonSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: RaisedButton(
                color: kPrimaryColor,
                textColor: Colors.white,
                child: Text(
                  "Cập nhật",
                ),
                onPressed: () async {
                  log("no: " + data.name);

                  if (await API_HELPER.updateStock(data) == true) {
                    _showToast(context);
                    Navigator.pop(context);
                  }
                }))
      ],
    );
  }

  void _showToast(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Đã lưu thành công"),
        ],
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 16.0,
            right: 16.0,
          );
        });
    log("print test");
  }

  Widget get _activeSection {
    return Row(children: [
      Expanded(
          child: MyCheckbox(
        is_active: data.is_active,
        title: "Đang hoạt động",
        onChangedCheck: (checkedValue) {
          data.is_active = checkedValue;
        },
      ))
    ]);
  }

  Widget get _nameSection {
    return Row(
      children: [
        Expanded(
            child: MyTextField(
          title: "Tên",
          text: data.name,
          onChangedText: (textValue) {
            data.name = textValue;
          },
        )),
      ],
    );
  }

  Widget get _noSection {
    return Row(
      children: [
        Expanded(
            child: MyTextField(
          title: "Mã",
          text: data.no,
          onChangedText: (textValue) {
            data.no = textValue;
          },
        )),
      ],
    );
  }
}
