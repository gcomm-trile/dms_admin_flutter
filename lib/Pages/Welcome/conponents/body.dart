import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:dms_admin/Pages/Login/widgets/login_page.dart';
import 'package:dms_admin/Pages/Welcome/conponents/background.dart';
import 'package:dms_admin/components/rounded_button.dart';
import 'package:dms_admin/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Đăng nhập",
              press: () {
                Navigator.pushNamed(context, "login");
              },
            ),
            RoundedButton(
              text: "Đăng kí",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
