import 'package:flutter/material.dart';

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
