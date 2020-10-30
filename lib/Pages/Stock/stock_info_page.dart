import 'dart:developer';

import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Models/stock.dart';
import 'package:dms_admin/components/my_checkbox.dart';
import 'package:dms_admin/components/my_textfield.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class StockInfoPage extends StatelessWidget {
  StockInfoPage(this.data, {Key key}) : super(key: key);
  final Stock data;
  TextEditingController _noController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _noController.text = data.no;
    _nameController.text = data.name;

    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(5),
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
                    UI.showSuccess( "Đã cập nhật thành công");
                    // Navigator.pop(context);
                  } else {
                    UI.showError(
                         "Có lỗi trong quá trình cập nhật dữ liệu");
                  }
                }))
      ],
    );
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
