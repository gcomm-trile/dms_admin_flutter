import 'dart:developer';
import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/components/my_checkbox.dart';
import 'package:dms_admin/components/image_picker.dart';
import 'package:dms_admin/components/my_textfield.dart';
import 'package:dms_admin/data/model/product.dart';

import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage(this.data, {Key key}) : super(key: key);
  Product data;
  TextEditingController _productNoController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  FToast fToast;

  @override
  Widget build(BuildContext context) {
    _productNoController.text = data.no;
    _productNameController.text = data.name;
    _productDescriptionController.text = data.description;
    _productPriceController.text = data.orderPrice.toString();
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                _headerSection,
                Expanded(
                    child: ListView(
                  children: [
                    _productNoSection,
                    _productNameSection,
                    _productDescriptionSection,
                    _productPriceSection,
                    _productImageSection,
                    _productActiveSection
                  ],
                )),
                _productUpdateButtonSection(context)
              ],
            )));
  }

  Widget get _headerSection {
    return Text(
      "THÔNG TIN SẢN PHẨM",
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  Widget get _productDescriptionSection {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: _productDescriptionController,
          decoration: InputDecoration(
            labelText: 'Mô tả sản phẩm',
          ),
          maxLines: 3,
        ))
      ],
    );
  }

  Widget get _productImageSection {
    return Row(
      children: [ImagePicker(width: 150, height: 150, path: data.imagePath)],
    );
  }

  Widget _productUpdateButtonSection(BuildContext context) {
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
                  log("productNo: " + _productNoController.text);
                  var product = new Product();
                  product.id = data.id;
                  product.description = _productDescriptionController.text;
                  product.no = _productNoController.text;
                  product.name = _productNameController.text;
                  product.orderPrice = int.parse(_productPriceController.text);
                  product.isActive = true;
                  product.imagePath = data.imagePath;
                  if (await API_HELPER.updateProduct(product) == true) {
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
    // final scaffold = Scaffold.of(context);
    // scaffold.showSnackBar(
    //   SnackBar(
    //     content: const Text('Đã cập nhật thành công'),
    //     // action: SnackBarAction(
    //     //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    //   ),
    // );
    log("print test");
  }

  Widget get _productActiveSection {
    return Row(children: [
      Expanded(
          child: MyCheckbox(
        isActive: data.isActive,
        title: "Đang hoạt động",
        onChangedCheck: (checkedValue) {
          log("check change " + checkedValue.toString());
          data.isActive = checkedValue;
        },
      ))
    ]);
  }

  Widget get _productNameSection {
    return Row(
      children: [
        Expanded(
            child: MyTextField(
          text: data.name,
          title: "Tên",
          onChangedText: (textValue) {
            data.name = textValue;
          },
        )),
      ],
    );
  }

  Widget get _productNoSection {
    return Row(
      children: [
        Expanded(
            child: MyTextField(
          text: data.no,
          title: "Mã",
          onChangedText: (textValue) {
            data.no = textValue;
          },
        )),
      ],
    );
  }

  Widget get _productPriceSection {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
                controller: _productPriceController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(labelText: 'Giá sản phẩm'))),
      ],
    );
  }
}
