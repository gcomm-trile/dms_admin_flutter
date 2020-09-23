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
            ),
            RoundedPasswordField(),
            RoundedButton(
                text: "ĐĂNG NHẬP",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductPage()),
                  );
                }),
            SizedBox(height: 30),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushNamed(context, 'signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
