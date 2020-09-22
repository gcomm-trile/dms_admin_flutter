import 'package:dms_admin/Models/product.dart';

import 'package:dms_admin/components/checkbox.dart';
import 'package:dms_admin/components/image_picker.dart';
import 'package:dms_admin/components/rounded_input_field.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage(this.data, {Key key}) : super(key: key);
  final Product data;
  @override
  Widget build(BuildContext context) {
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
                _productUpdateButtonSection
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
          decoration: InputDecoration(labelText: 'Nhập mô tả sản phẩm'),
          maxLines: 3,
        ))
      ],
    );
  }

  Widget get _productImageSection {
    return Row(
      children: [ImagePicker(width: 150, height: 150, path: data.image_path)],
    );
  }

  Widget get _productUpdateButtonSection {
    return Row(
      children: [
        Expanded(
            child: RaisedButton(
                color: kPrimaryColor,
                textColor: Colors.white,
                child: Text(
                  "Cập nhật",
                ),
                onPressed: () {}))
      ],
    );
  }

  Widget get _productActiveSection {
    return Row(children: [
      Expanded(child: MyCheckbox(data.isActive, "Đang hoạt động"))
    ]);
  }

  Widget get _productNameSection {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
                decoration: InputDecoration(labelText: 'Nhập tên sản phẩm'))),
      ],
    );
  }

  Widget get _productNoSection {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(labelText: 'Nhập mã sản phẩm'),
        )),
      ],
    );
  }

  Widget get _productPriceSection {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(labelText: 'Nhập giá sản phẩm'))),
      ],
    );
  }
}
