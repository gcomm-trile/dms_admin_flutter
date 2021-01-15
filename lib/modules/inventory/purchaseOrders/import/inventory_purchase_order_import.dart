import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'inventory_purchase_order_import_controller.dart';

class InventoryPurchaseOrderImportPage extends StatelessWidget {
  final purchaseOrderId;
  dp.DatePickerStyles styles;
  InventoryPurchaseOrderImportController controller =
      InventoryPurchaseOrderImportController(repository: Get.find());
  InventoryPurchaseOrderImportPage({Key key, @required this.purchaseOrderId})
      : super(key: key);
  Widget build(BuildContext context) {
    styles = dp.DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: Colors.white),
        selectedSingleDateDecoration:
            BoxDecoration(color: Colors.blue, shape: BoxShape.circle));

    return Scaffold(
      body: Row(
        children: [
          AppDrawer(),
          Expanded(child: _buildBodySection()),
        ],
      ),
    );
  }

  final double widthQuantibox = 80.0;
  var sizedBox = SizedBox(
    width: 10,
  );
  _buildRowListViewSection(Product product) {
    return Row(children: <Widget>[
      Image.network(
        product.imagePath,
        width: kSizeProductImageWidth,
        height: kSizeProductImageHeight,
      ),
      sizedBox,
      Expanded(
        child: Container(child: Text(product.name)),
      ),
      sizedBox,
      Container(
          width: 40,
          child: Text(
            kNumberFormat.format(product.qtyRemaining),
          )),
      sizedBox,
      Container(
        width: 80,
        padding: EdgeInsets.all(2.0),
        child: NumberInputWithIncrementDecrement(
          controller: product.qtyImportedTextEditingController,
          min: 1,
          max: 999999,
          numberFieldDecoration: InputDecoration(border: InputBorder.none),
          initialValue: product.qtyRemaining,
        ),
      ),
      sizedBox,
      Container(
        width: 80,
        child: Row(
          children: [
            Text(
              '${product.qtyCurrentStock}',
            ),
            Icon(Icons.arrow_right_alt),
            Text(
              '${product.qtyAfterImport}',
            ),
          ],
        ),
      ),
      sizedBox,
      Container(
        width: 90,
        child: Text(
          kNumberFormat.format(1000000) + ' đ',
        ),
      ),
      sizedBox,
      Container(
        width: 100,
        child: Text(
          kNumberFormat.format(1000000) + ' đ',
        ),
      )
    ]);
  }

  _buildHeaderListViewSection() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Sản phẩm',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          color: Colors.red,
          width: 40,
          child: Text(
            'Đặt',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 80,
          child: Text(
            'Nhận',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 80,
          child: Text(
            'Trong kho',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 90,
          child: Text(
            'Giá',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        sizedBox,
        Container(
          width: 100,
          child: Text(
            'Thành tiền',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInformationSection() {
    return [
      _buildVendorSection(),
      SizedBox(
        height: 10,
      ),
      _buildStockSection(),
      SizedBox(
        height: 10,
      ),
      _buildNoteSection(),
      SizedBox(
        height: 10,
      ),
      _buildAdditionalSection(),
      SizedBox(
        height: 10,
      )
    ];
  }

  _buildHeaderBarSection() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            'Chi tiết phiếu mua hàng',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          RaisedButton(
            onPressed: () {
              controller.save();
            },
            color: Colors.blue,
            child: Container(
              height: 40,
              width: 100,
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  Text(
                    'NHẬN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildProductSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildHeaderListViewSection(),
        Divider(
          thickness: 2,
        ),
        Expanded(
          child: controller.result.value.products == null
              ? Container()
              : ListView.builder(
                  itemCount: controller.result.value.products.length,
                  itemBuilder: (context, index) {
                    return _buildRowListViewSection(
                        controller.result.value.products[index]);
                  },
                ),
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }

  _buildBodySection() {
    return GetX<InventoryPurchaseOrderImportController>(
      init: controller,
      initState: (state) => controller.getId(purchaseOrderId),
      builder: (_) {
        print('rebuild');

        return controller.isBusy.value == true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildHeaderBarSection(),
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(213, 220, 230, 1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                color: Color.fromRGBO(213, 220, 230, 1),
                                child: _buildProductSection()),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: _buildInformationSection(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  _buildStockSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(20),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kho',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.stock.value.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildVendorSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(10),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nhà Phân Phối',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.vendor.value.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              controller.isExpandedVendor.value == false
                  ? FlatButton(
                      onPressed: () => controller.setExpandedVendor(true),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            Text(
                              'Xem thêm',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FlatButton(
                          onPressed: () => controller.setExpandedVendor(false),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.format_indent_decrease,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Thu gọn',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          'Thông tin nhà phân phối',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.vendor.value.phone,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.address,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.ward,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.district,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.province,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.vendor.value.country,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  _buildNoteSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(20),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông Tin Ghi Chú',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Text(
            controller.result.value.note == null ||
                    controller.result.value.note.isEmpty == true
                ? '--'
                : controller.result.value.note,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildAdditionalSection() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white70,
      ),
      padding: EdgeInsets.all(20),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông Tin Bổ Sung',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Text(
            'Ngày dự kiến',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Container(
            child: Text(DateTimeHelper.day2Text(
                controller.result.value.planImportDate)),
          ),
          Text(
            'Số tham chiếu',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Text(
            controller.result.value.refDocumentNote.isEmpty
                ? '--'
                : controller.result.value.refDocumentNote,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
