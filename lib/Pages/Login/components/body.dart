import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/Pages/Product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:dms_admin/components/already_have_an_account_acheck.dart';
import 'package:dms_admin/components/rounded_button.dart';
import 'package:dms_admin/components/rounded_input_field.dart';
import 'package:dms_admin/components/rounded_password_field.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _username = "";
    String _password = "";
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: 200,
            // ),
            SizedBox(height: 30),
            RoundedInputField(
              hintText: "Tên tài khoản",
              icon: Icons.person,
              onChanged: (value) {
                _username = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _password = value;
              },
            ),
            RoundedButton(
                text: "ĐĂNG NHẬP",
                press: () async {
                  if (_username.isNotEmpty && _password.isNotEmpty) {
                    var result = await API_HELPER.login(_username, _password);
                    if (result.isEmpty) {
                      UI.showError(
                           "Xảy ra lỗi trong quá trình đăng nhập");
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductPage()),
                      );
                    }
                  } else {
                    UI.showError(
                        "Xảy ra lỗi trong quá trình đăng nhập");
                  }
                }),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
