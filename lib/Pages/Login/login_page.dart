import 'package:dms_admin/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

const primaryColor = Color.fromRGBO(109, 192, 45, 1);
const secondColor = Color.fromRGBO(147, 211, 91, 0.7);

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLoading = false;
  var usernameEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: Scaffold(
            body: !isLoading
                ? Stack(children: [
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
                              textEditingController: usernameEditingController,
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
                              textEditingController: passwordEditingController,
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
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white))
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
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              side: BorderSide(color: primaryColor)),
                          onPressed: () {},
                          color: primaryColor,
                          textColor: Colors.white,
                          child: Text("Đăng nhập".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ))
                  ])
                : LoadingControl()));
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

class TextInput extends StatelessWidget {
  final IconData icon;
  final bool isPassword;
  final String hintText;
  final TextEditingController textEditingController;
  const TextInput(
      {Key key,
      @required this.icon,
      this.isPassword = false,
      @required this.hintText,
      @required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isPassword,
      style: TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: Container(width: 50, child: Icon(icon)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6)))),
    );
    // return Container(
    //     decoration: BoxDecoration(
    //       // color: Colors.transparent,
    //       border: Border.all(width: 2.0),
    //       borderRadius: BorderRadius.all(
    //           Radius.circular(5.0) //         <--- border radius here
    //           ),
    //       // border: OutlinedBorder(
    //       //     borderSide: BorderSide(color: Color(0xffCED0D2), width: 1),
    //       //     borderRadius: BorderRadius.all(Radius.circular(6))),
    //       // borderRadius: BorderRadius.circular(5)),
    //     ),
    //     child: Row(
    //       children: [
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Icon(icon, color: Colors.black),
    //         SizedBox(
    //           width: 10,
    //         ),
    //         Expanded(
    //             child: TextField(
    //           // style: GoogleFonts.lato(color: Colors.white),
    //           // cursorColor: Colors.white,
    //           obscureText: isPassword,
    //           decoration: InputDecoration(
    //             border: InputBorder.none,
    //           ),
    //         )),
    //         SizedBox(
    //           width: 10,
    //         ),
    //       ],
    //     ));
  }
}
