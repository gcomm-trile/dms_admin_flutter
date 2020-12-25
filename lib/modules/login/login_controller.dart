import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/repository/login_repository.dart';
import 'package:dms_admin/modules/order/order_binding.dart';
import 'package:dms_admin/modules/order/order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepository repository;
  LoginController({@required this.repository});

  var usernameEditingController = TextEditingController(text: 'trile');
  var passwordEditingController = TextEditingController(text: '123123123');
  var canShowButton = true.obs;

  loginAsync() async {
    canShowButton.value = false;

    if (usernameEditingController.text.isNotEmpty &&
        passwordEditingController.text.isNotEmpty) {
      var result = await repository.login(
          usernameEditingController.text, passwordEditingController.text);
      if (result.isEmpty) {
        UI.showError("Xảy ra lỗi trong quá trình đăng nhập");
      } else {
        Get.to(OrderPage(),
            binding: OrderBinding(), transition: Transition.zoom);
      }
    } else {
      // UI.showError("Xảy ra lỗi trong quá trình đăng nhập");
    }
    canShowButton.value = true;
  }
}
