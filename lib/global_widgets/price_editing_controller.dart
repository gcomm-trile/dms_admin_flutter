import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

import 'money_format.dart';

class PriceEditingController extends TextEditingController {
  PriceEditingController(String newValue) {
    value = value.copyWith(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
      composing: TextRange.empty,
    );
  }

  @override
  set text(String newText) {
    var newValue = kNumberFormat.format(MoneyFormat.moneyFormat(newText));
    print(newText);
    value = value.copyWith(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
      composing: TextRange.empty,
    );
    print('done set new text ' + value.text);
  }
}
