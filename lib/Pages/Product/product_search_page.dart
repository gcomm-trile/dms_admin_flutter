import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/inventory.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';

class ProductSearchPage extends StatefulWidget {
  final String stock_id;
  final Function(Set<Inventory> selectedProducts) savedData;
  ProductSearchPage({Key key, this.savedData, this.stock_id}) : super(key: key);

  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final _checkedProduct = new Set<Inventory>();
  Future<List<Inventory>> products;
  @override
  void initState() {
    super.initState();
    products = API_HELPER.getInventory(widget.stock_id);
  }

  Widget get _buildAPI {
    return FutureBuilder<List<Inventory>>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return _buildRow(context, index, snapshot.data[index]);
              });
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else
          return LoadingControl();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300.0,
        height: double.infinity,
        child: Column(
          children: [
            // MyTextField(
            //   text: "",
            //   title: "Tìm sản phẩm",
            //   onChangedText: (textValue) {},
            // ),
            // _buildHeader,
            Expanded(child: _buildAPI),
            RaisedButton(
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
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

  Widget get _buildHeader {
    return Row(
      children: [
        Container(
          width: 40,
        ),
        Expanded(
          child: Text("Tên SP"),
        ),
        Container(
          width: 40.0,
          child: Text(
            "Tồn",
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  Widget _buildRow(BuildContext context, int index, Inventory product) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedProduct.contains(product);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isChecked)
            _checkedProduct.remove(product);
          else {
            _checkedProduct.add(product);
          }
        });
      },
      child: Row(
        children: [
          Container(
            width: 40,
            child: Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: color,
            ),
          ),
          Expanded(
            child: Text(
              product.productName,
              style: TextStyle(color: color),
            ),
          ),
          Container(
            width: 40.0,
            child: Text(
              product.currentQty.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(color: color),
            ),
          )
        ],
      ),
    );
  }
}
