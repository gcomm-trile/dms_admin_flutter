import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/components/my_textfield.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';

class ProductSearchPage extends StatefulWidget {
  final Function(Set<Product> selectedProducts) savedData;
  ProductSearchPage({Key key, this.savedData}) : super(key: key);

  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final _checkedProduct = new Set<Product>();
  Future<List<Product>> products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = API_HELPER.fetchProduct();
  }

  Widget get _buildAPI {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return _buildRow(context, index, snapshot.data[index]);
              });
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: 400.0,
        child: Column(
          children: [
            // MyTextField(
            //   text: "",
            //   title: "Tìm sản phẩm",
            //   onChangedText: (textValue) {},
            // ),
            Expanded(child: _buildAPI),
            RaisedButton(
              child: Icon(Icons.save),
              color: kPrimaryColor,
              onPressed: () {
                setState(() {
                  widget.savedData(_checkedProduct);
                  Navigator.pop(context);
                });
              },
            )
          ],
        ));
  }

  Widget _buildRow(BuildContext context, int index, Product product) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedProduct.contains(product);
    return ListTile(
        onTap: () {
          setState(() {
            if (isChecked)
              _checkedProduct.remove(product);
            else {
              _checkedProduct.add(product);
            }
          });
        },
        leading: Icon(
          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: color,
        ),
        title: Text(
          product.name,
          style: TextStyle(color: color),
        ));
  }
}
