import 'package:dms_admin/global_widgets/text_input.dart';
import 'package:dms_admin/modules/login/login_controller.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

const primaryColor = Color.fromRGBO(109, 192, 45, 1);
const secondColor = Color.fromRGBO(147, 211, 91, 0.7);

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: Scaffold(
            body: Stack(children: [
      Column(
        children: [
          Spacer(),
          Image.asset(
            'assets/images/ic_launcher.png',
            height: 102,
            width: 102,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            width: 250,
            child: Center(
              child: TextInput(
                icon: Icons.person,
                isPassword: false,
                hintText: 'Tài khoản',
                textEditingController: controller.usernameEditingController,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 250,
            child: Center(
              child: TextInput(
                icon: Icons.lock,
                isPassword: true,
                hintText: 'Mật khẩu',
                textEditingController: controller.passwordEditingController,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            height: 120,
            child: CustomPaint(
              painter: MyCustomPaint(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Spacer(),
                    Text('-Power by Easy Solutions Company-',
                        style: GoogleFonts.lato(
                            fontStyle: FontStyle.italic, color: Colors.white))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      Positioned(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: 140,
                height: 40,
                margin: EdgeInsets.only(bottom: 100),
                child: Obx(() => !controller.canShowButton.value
                    ? Center(
                        child: SpinKitWave(color: kPrimaryColor),
                      )
                    : RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            side: BorderSide(color: primaryColor)),
                        onPressed: () async {
                          await controller.loginAsync();
                        },
                        color: primaryColor,
                        textColor: Colors.white,
                        child: Text("Đăng nhập".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                      )))),
      )
    ])));
  }
}

class MyCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint firstPaint = Paint();
    firstPaint.color = secondColor;

    final Path firstPath = Path();
    firstPath.quadraticBezierTo(size.width / 2, 75, size.width, 0);
    // firstPath.lineTo(size.width, 0);
    firstPath.lineTo(size.width, size.height);
    firstPath.lineTo(0, size.height);
    canvas.drawPath(firstPath, firstPaint);
    final Paint secondPaint = Paint();
    secondPaint.color = primaryColor;
    final Path secondPath = Path();
    secondPath.moveTo(0, 40);
    secondPath.quadraticBezierTo(size.width / 2, 75, size.width, 5);
    // firstPath.lineTo(size.width, 0);
    secondPath.lineTo(size.width, size.height);
    secondPath.lineTo(0, size.height);

    canvas.drawPath(secondPath, secondPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
