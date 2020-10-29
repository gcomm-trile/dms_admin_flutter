import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UI {
  static void showSuccess(String message) {
    Get.snackbar('Thành công', message);
    // var fToast = FToast();
    // fToast.init(context);
    // Widget toast = Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(25.0),
    //     color: Colors.greenAccent,
    //   ),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Icon(Icons.check),
    //       SizedBox(
    //         width: 12.0,
    //       ),
    //       Text(message),
    //     ],
    //   ),
    // );
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         right: 16.0,
    //       );
    //     });
    // log("print test");
  }

  static void showError(String message) {
    Get.snackbar('Lỗi', message,
        snackPosition: SnackPosition.TOP,
        backgroundGradient: LinearGradient(colors: [Colors.red, Colors.orange]),
        colorText: Colors.white,
        margin: EdgeInsets.all(10));
  }
}
