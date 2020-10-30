import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Pages/Dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var usernameEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var canShowButton = true.obs;
  @override
  void initState() {}

  loginAsync() async {
    canShowButton.value = false;

    if (usernameEditingController.text.isNotEmpty &&
        passwordEditingController.text.isNotEmpty) {
      var result = await API_HELPER.login(
          usernameEditingController.text, passwordEditingController.text);
      if (result.isEmpty) {
        UI.showError("Xảy ra lỗi trong quá trình đăng nhập");
      } else {
        Get.to(DashboardPage(), transition: Transition.zoom);
      }
    } else {
      // UI.showError("Xảy ra lỗi trong quá trình đăng nhập");
    }
    canShowButton.value = true;
  }
}
