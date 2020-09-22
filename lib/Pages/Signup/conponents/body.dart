import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dms_admin/Pages/Login/login_page.dart';
import 'package:dms_admin/Pages/Signup/conponents/background.dart';
import 'package:dms_admin/components/already_have_an_account_acheck.dart';
import 'package:dms_admin/components/rounded_button.dart';
import 'package:dms_admin/components/rounded_input_field.dart';
import 'package:dms_admin/components/rounded_password_field.dart';

class Body extends StatelessWidget {
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
            //   "assets/icons/signup.svg",
            // ),
            RoundedPasswordField(),
            RoundedPasswordField(),
            RoundedButton(
              text: "ĐĂNG KÍ",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
