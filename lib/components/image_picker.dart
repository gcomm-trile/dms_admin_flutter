import 'package:dms_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';

class ImagePicker extends StatefulWidget {
  final double width;
  final double height;
  final String path;
  ImagePicker({Key key, this.width, this.height, this.path}) : super(key: key);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  String path;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      path = widget.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(path, width: widget.width, height: widget.height),
        RaisedButton(
            color: kPrimaryColor,
            textColor: Colors.white,
            child: Text("Upload hình"),
            onPressed: () async {
              final _image = await FlutterWebImagePicker.getImage;
              setState(() {
                path =
                    "https://miro.medium.com/max/700/1*BzcKF4qdbLIFFB6XL8x-9A.png";
              });
            })
      ],
    );
  }
}
