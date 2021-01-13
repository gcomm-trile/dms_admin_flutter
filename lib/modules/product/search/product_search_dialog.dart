import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Models/inventory.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/modules/product/search/product_search_controller.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSearchDialog extends StatelessWidget {
  final ProductSearchController controller =
      ProductSearchController(repository: Get.find());
  final String stockId;
  final Function(Set<Inventory> selectedProducts) savedData;
  ProductSearchDialog({Key key, this.savedData, this.stockId})
      : super(key: key);

  final _checkedProduct = new Set<Inventory>();
  Future<List<Inventory>> products;

  Widget get _buildAPI {
    return GetX<ProductSearchController>(
      init: controller,
      initState: controller.getAll(),
      builder: (_) {
        if (controller.isBusy.value == true)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    shrinkWrap: true,
                    itemCount: controller.result.value.length,
                    itemBuilder: (context, index) {
                      return _buildRow(
                          context, index, controller.result.value[index]);
                    }),
              )
            ],
          );
        }
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
            Expanded(child: _buildAPI),
            RaisedButton(
              child: Icon(
                Icons.done,
                color: Colors.white,
              ),
              color: kPrimaryColor,
              onPressed: () {
                // setState(() {
                //   widget.savedData(_checkedProduct);
                //   Navigator.pop(context);
                // });
              },
            )
          ],
        ));
  }

  Widget _buildRow(BuildContext context, int index, Product product) {
    print('come here');
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedProduct.contains(product);
    return GestureDetector(
      onTap: () {
        controller.setChecked(product);
        // setState(() {
        //   if (isChecked)
        //     _checkedProduct.remove(product);
        //   else {
        //     _checkedProduct.add(product);
        //   }
        // });
      },
      child: Row(
        children: [
          Container(
            width: 40,
            child: Icon(
              Icons.check_box,
              // product.checked.value
              //     ? Icons.check_box
              //     : Icons.check_box_outline_blank,
              color: color,
            ),
          ),
          Expanded(
            child: Text(
              product.name,
              style: TextStyle(color: color),
            ),
          ),
          Container(
            width: 40.0,
            child: Text(
              '0',
              textAlign: TextAlign.right,
              style: TextStyle(color: color),
            ),
          )
        ],
      ),
    );
  }
}
