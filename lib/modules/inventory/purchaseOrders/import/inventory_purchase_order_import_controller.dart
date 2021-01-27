import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/model/vendor.dart';
import 'package:dms_admin/data/repository/inventory_purchase_orders_repository.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';


class InventoryPurchaseOrderImportController extends GetxController {
  List<GlobalKey<NumberInputWithIncrementDecrementState>> _key =
      List<GlobalKey<NumberInputWithIncrementDecrementState>>();
  GlobalKey<NumberInputWithIncrementDecrementState> getKey(int index) =>
      _key[index];

  final InventoryPurchaseOrdersRepository repository;
  InventoryPurchaseOrderImportController({@required this.repository})
      : assert(repository != null);

  final String id = '';
  final isBusy = true.obs;
  final isExpandedVendor = false.obs;
  var result = Rx<PurchaseOrder>();
  var products = List<Product>().obs;
  final vendor = Rx<Vendor>();
  final stock = Rx<Stock>();

  void getId(String purchaseOrderId) {
    print(purchaseOrderId);
    print('run import');
    isBusy(true);
    repository.getId(purchaseOrderId).then((data) {
      print('return data import');
      result.value = data;

      vendor.value = result.value.vendors
          .where((element) => element.id == result.value.vendorId)
          .first;
      stock.value = result.value.stocks
          .where((element) => element.id == result.value.inStockId)
          .first;
      products(result.value.products);
      for (var item in result.value.products) {
        _key.add(GlobalKey());
      }
      isBusy(false);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  void getId2(String purchaseOrderId) {
    repository.getId(purchaseOrderId).then((data) {
      print('return data import');
      result.value = data;
      vendor.value = result.value.vendors
          .where((element) => element.id == result.value.vendorId)
          .first;
      stock.value = result.value.stocks
          .where((element) => element.id == result.value.inStockId)
          .first;
      products(result.value.products);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    });
  }

  void setExpandedVendor(bool value) {
    isExpandedVendor(value);
  }

  void import() {
    repository.nhanHang(result.value).then((data) {
      print(data);
      if (data.toString().isEmpty) {
        UI.showSuccess('Đã cập nhật thành công');
        Get.offAndToNamed(Routes.INVENTORY_PURCHASE_ORDERS);
      } else {
        UI.showError(data.toString());
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    });
  }

  void setInQty(int index, int newValue) {
    print('setInQty  at $index change to $newValue');
    var product = products[index];
    product.inQty = newValue;

    product.qtyImportedTextEditingController.text = newValue.toString();
    products[index] = product;
  }

  void setChecked(int index, bool value) {
    var product = products[index];
    product.inQty = value == true ? product.orderQty : 0;

    print(' set checked $value ${product.inQty}');
    products[index] = product;
  }

  getProductImported() {
    return products.where((e) => e.inQty > 0).length;
  }

  getQtyImported() {
    int result = 0;
    for (var product in products) {
      if (product.inQty > 0) result += product.inQty;
    }
    return result;
  }

  int getCountSelectedProduct() {
    return result.value.products
        .where((element) => element.checked == true)
        .length;
  }

  getTotalMoneyImported() {
    int result = 0;
    for (var product in products) {
      if (product.inQty > 0) result += product.inQty * product.orderPrice;
    }
    return result;
  }
}

// typedef void DiffIncDecCallBack(num newValue);

// /// This is the expected function definition for the callbacks via onSubmitted.
// /// The callback will be passed the new value.
// typedef void ValueCallBack(num newValue);

// enum ButtonArrangement {
//   /// Places both the buttons to the left of the text field.
//   leftEnd,

//   /// Places both the buttons to the right of the text field.
//   rightEnd,

//   /// Places increment button to the left and decrement button to the right.
//   incLeftDecRight,

//   /// Places increment button to the right and decrement button to the left.
//   incRightDecLeft,
// }

// class NumberInputWithIncrementDecrement extends StatefulWidget {
//   /// Key to be used for this widget.
//   final Key key;

//   /// Whether the user is able to interact or not
//   final bool enabled;

//   /// Provide a custom controller.
//   final TextEditingController controller;

//   final Function(int value) onValueChanged;

//   /// Decides the button placement using [ButtonArrangement].
//   /// Defaults to [ButtonArrangement.rightEnd]
//   final ButtonArrangement buttonArrangement;

//   /// Minimum value allowed for this field. Defaults to zero.
//   final num min;

//   /// Maximum value allowed for this field. Defaults to `double.infinity`.
//   final num max;

//   /// A factor by which the numeric value should be incremented or decremented.
//   /// e.g. Setting `incDecFactor=0.5` increments or decrement the number field by 0.5.
//   /// Defaults to 1.
//   final num incDecFactor;

//   /// Initial value for the number input field. Defaults to zero.
//   final num initialValue;

//   /// Decides if the field only accepts integer values.
//   /// Defaults to true.
//   final bool isInt;

//   /// Passed to [TextFormField.autovalidate]
//   /// defaults to [false]
//   final bool autovalidate;

//   /// Decoration for the TextFormField.
//   /// Defaults to a simple outline border.
//   final InputDecoration numberFieldDecoration;

//   /// Decoration for the whole widget.
//   /// defaults to a simple container with rounded border.
//   final Decoration widgetContainerDecoration;

//   /// validators for this field.
//   /// Defaults to [_NumberInputWithIncrementDecrementState._minMaxValidator] validator
//   /// based on the values of [min] and [max] field.
//   /// Note: These values default to [0] and [double.infinity] respectively.
//   ///
//   /// ```dart
//   /// String _minMaxValidator(String value) {
//   ///    return num.parse(value) < widget.min || num.parse(value) > widget.max
//   ///        ? 'Value should be between ${widget.min} and ${widget.max}'
//   ///        : null;
//   ///  }
//   /// ```
//   final FormFieldValidator<String> validator;

//   /// The [TextStyle] that will passed down to [TextFormField.style].
//   /// This is the style of the text being edited.
//   ///
//   /// For e.g following will make the numbers appear green.
//   /// ````dart
//   /// NumberInputPrefabbed.squaredButtons(
//   ///   controller: TextEditingController(),
//   ///   style: TextStyle(
//   ///         color: Colors.green,
//   ///         fontSize: 28,
//   ///   ),
//   /// );
//   /// ```
//   final TextStyle style;

//   /// Decoration for the Increment Icon
//   /// Defaults to a black border in the bottom.
//   final Decoration incIconDecoration;

//   /// Decoration for the Decrement Icon
//   /// Defaults to null;
//   final Decoration decIconDecoration;

//   /// Icon to be used for Increment button.
//   final IconData incIcon;

//   /// Icon size to be used for Increment button.
//   /// Defaults to size defined in IconTheme
//   final double incIconSize;

//   /// Icon color to be used for Increment button.
//   /// Defaults to color defined in IconTheme
//   final Color incIconColor;

//   /// A call back function to be called on successful increment.
//   /// This will not be called if the internal validators fail.
//   final DiffIncDecCallBack onIncrement;

//   /// A call back function to be called on successful submit.
//   /// This will not be called if the internal validators fail.
//   final ValueCallBack onSubmitted;

//   /// Icon to be used for Decrement button.
//   final IconData decIcon;

//   /// Icon size to be used for Decrement button.
//   /// Defaults to size defined in IconTheme
//   final double decIconSize;

//   /// Icon color to be used for Decrement button.
//   /// Defaults to color defined in IconTheme
//   final Color decIconColor;

//   /// A call back function to be called on successful decrement.
//   /// This will not be called if the internal validators fail.
//   final DiffIncDecCallBack onDecrement;

//   /// No of digits after decimal point.
//   /// Defaults to value of 2 for non int fields.
//   /// Should be between 0 and 20 inclusively.
//   final int fractionDigits;

//   /// A scaling factor for the width of the widget.
//   /// Defaults to 1.
//   final double scaleWidth;

//   /// A scaling factor for the height of the widget.
//   /// Defaults to 1.
//   final double scaleHeight;

//   /// Show a transparent separator between the increment & decrement buttons.
//   /// Defaults to false.
//   final bool separateIcons;

//   /// Background color of increment decrement buttons.
//   final Color incDecBgColor;
//   NumberInputWithIncrementDecrement({
//     @required this.controller,
//     this.key,
//     this.enabled = true,
//     this.buttonArrangement = ButtonArrangement.rightEnd,
//     this.min = 0,
//     this.max = double.infinity,
//     this.initialValue = 0,
//     this.incDecFactor = 1,
//     this.isInt = true,
//     this.autovalidate = false,
//     this.numberFieldDecoration,
//     this.widgetContainerDecoration,
//     this.validator,
//     this.style,
//     this.incIcon = Icons.arrow_drop_up,
//     this.decIcon = Icons.arrow_drop_down,
//     this.fractionDigits = 2,
//     this.scaleWidth = 1.0,
//     this.scaleHeight = 1.0,
//     this.incIconSize,
//     this.decIconSize,
//     this.decIconColor,
//     this.incIconColor,
//     this.onDecrement,
//     this.onIncrement,
//     this.onSubmitted,
//     this.separateIcons = false,
//     this.decIconDecoration,
//     this.incIconDecoration,
//     this.incDecBgColor,
//     this.onValueChanged,
//   });

//   @override
//   _NumberInputWithIncrementDecrementState createState() =>
//       _NumberInputWithIncrementDecrementState();
// }

// class _NumberInputWithIncrementDecrementState
//     extends State<NumberInputWithIncrementDecrement> {
//   TextEditingController _controller;
//   int oldValue;
//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller;
//     //  Setting the initial value for the field.
//     _controller.text = widget.isInt
//         ? widget.initialValue.toString()
//         : widget.initialValue.toStringAsFixed(widget.fractionDigits);

//     _controller = widget.controller;
//     //  Setting the initial value for the field.

//     _controller.addListener(() {
//       int newValue = 0;
//       if (_controller.text == null || _controller.text.isEmpty)
//         newValue = 0;
//       else
//         newValue = int.parse(_controller.text);
//       widget.onValueChanged(newValue);
//       // if (newValue > widget.max || newValue < widget.min) {
//       //   _controller.text = oldValue.toString();
//       // } else
//       //   widget.onValueChanged(newValue);
//     });
//   }

//   void setValue(int value) {
//     print('call here');
//     _controller.text = value.toString();
//   }

//   String _minMaxValidator(String value) {
//     return value != null &&
//             value.isNotEmpty &&
//             (num.parse(value) < widget.min || num.parse(value) > widget.max)
//         ? 'Value should be between ${widget.min} and ${widget.max}'
//         : null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('rebuild number');
//     return Transform(
//       transform:
//           Matrix4.diagonal3Values(widget.scaleWidth, widget.scaleHeight, 1.0),
//       child: Container(
//         decoration: widget.widgetContainerDecoration ??
//             BoxDecoration(
//               borderRadius: BorderRadius.circular(5.0),
//               border: Border.all(
//                 color: Colors.blueGrey,
//                 width: 2.0,
//               ),
//             ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             if (widget.buttonArrangement == ButtonArrangement.incLeftDecRight)
//               _buildIncrementButton(),
//             if (widget.buttonArrangement == ButtonArrangement.incRightDecLeft)
//               _buildDecrementButton(),
//             if (widget.buttonArrangement == ButtonArrangement.leftEnd)
//               _buildColumnOfButtons(),
//             Expanded(
//               flex: 1,
//               child: TextFormField(
//                   validator: widget.validator ?? _minMaxValidator,
//                   style: widget.style,
//                   enabled: widget.enabled,
//                   textAlign: TextAlign.center,
//                   autovalidate: widget.autovalidate,
//                   decoration: widget.numberFieldDecoration ??
//                       InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                   controller: _controller,
//                   keyboardType: TextInputType.numberWithOptions(
//                     decimal: !widget.isInt,
//                     signed: true,
//                   ),
//                   inputFormatters: <TextInputFormatter>[
//                     widget.isInt
//                         ? FilteringTextInputFormatter.digitsOnly
//                         : FilteringTextInputFormatter.allow(
//                             RegExp("[0-9.]"),
//                           )
//                   ],
//                   onFieldSubmitted: (value) {
//                     if (this.widget.onSubmitted != null) {
//                       num newVal;
//                       try {
//                         newVal = this.widget.isInt
//                             ? int.parse(value)
//                             : double.parse(value);
//                       } catch (e) {
//                         return;
//                       }
//                       // Auto keep new value inside min max
//                       newVal = newVal > widget.min ? newVal : widget.min;
//                       newVal = newVal < widget.max ? newVal : widget.max;

//                       this.widget.onSubmitted(newVal);
//                     }
//                   }),
//             ),
//             if (widget.buttonArrangement == ButtonArrangement.incLeftDecRight)
//               _buildDecrementButton(),
//             if (widget.buttonArrangement == ButtonArrangement.incRightDecLeft)
//               _buildIncrementButton(),
//             if (widget.buttonArrangement == ButtonArrangement.rightEnd)
//               _buildColumnOfButtons(),
//           ],
//         ),
//       ),
//     );
//   }

//   Column _buildColumnOfButtons() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         _buildIncrementButton(),
//         if (widget.separateIcons)
//           Container(
//             color: Colors.transparent,
//             height: 2,
//           ),
//         _buildDecrementButton(),
//       ],
//     );
//   }

//   Ink _buildDecrementButton() {
//     return Ink(
//       decoration: widget.decIconDecoration ??
//           BoxDecoration(
//             border: widget.buttonArrangement == ButtonArrangement.leftEnd ||
//                     widget.buttonArrangement == ButtonArrangement.rightEnd
//                 ? null
//                 : Border(
//                     top: BorderSide(color: Colors.black),
//                     bottom: BorderSide(color: Colors.black),
//                   ),
//           ),
//       child: InkWell(
//         splashColor: widget.incDecBgColor,
//         child: Icon(
//           widget.decIcon,
//           size: widget.decIconSize,
//           color: widget.decIconColor,
//         ),
//         onTap: !widget.enabled
//             ? null
//             : () {
//                 var currentValue = widget.isInt
//                     ? int.parse(_controller.text)
//                     : double.parse(_controller.text);
//                 setState(() {
//                   currentValue = currentValue - widget.incDecFactor;
//                   currentValue =
//                       currentValue > widget.min ? currentValue : widget.min;
//                   _controller.text = widget.isInt
//                       ? currentValue.toString()
//                       : currentValue.toStringAsFixed(
//                           widget.fractionDigits); // decrementing value
//                   // decrement callback
//                   if (widget.onDecrement != null) {
//                     widget.onDecrement(currentValue);
//                   }
//                 });
//               },
//       ),
//     );
//   }

//   Ink _buildIncrementButton() {
//     return Ink(
//       decoration: widget.incIconDecoration ??
//           BoxDecoration(
//             border: widget.buttonArrangement == ButtonArrangement.leftEnd ||
//                     widget.buttonArrangement == ButtonArrangement.rightEnd
//                 ? Border(
//                     bottom: BorderSide(color: Colors.black),
//                   )
//                 : Border(
//                     top: BorderSide(color: Colors.black),
//                     bottom: BorderSide(color: Colors.black),
//                   ),
//           ),
//       child: InkWell(
//         splashColor: widget.incDecBgColor,
//         child: Icon(
//           widget.incIcon,
//           size: widget.incIconSize,
//           color: widget.incIconColor,
//         ),
//         onTap: !widget.enabled
//             ? null
//             : () {
//                 var currentValue = widget.isInt
//                     ? int.parse(_controller.text)
//                     : double.parse(_controller.text);
//                 setState(() {
//                   currentValue = currentValue + widget.incDecFactor;
//                   currentValue =
//                       currentValue < widget.max ? currentValue : widget.max;
//                   _controller.text = widget.isInt
//                       ? currentValue.toString()
//                       : currentValue.toStringAsFixed(
//                           widget.fractionDigits); // incrementing value
//                   // increment call back.
//                   if (widget.onIncrement != null) {
//                     widget.onIncrement(currentValue);
//                   }
//                 });
//               },
//       ),
//     );
//   }
// }
