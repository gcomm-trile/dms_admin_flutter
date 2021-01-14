import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const SERVER_URL = "http://localhost:58985/";
const kIconSize = 32.0;
var kNumberFormat = new NumberFormat("#,###");
// const SERVER_URL = "http://gcomm.online:9812/";
const kPrimaryColor = Color.fromRGBO(109, 192, 45, 1); //Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kWidthProductNo = 80.0;
const kWidthSeqNo = 50.0;
const kFontListViewText = 15.0;
const kSizeProductImageWidth = 100.0;
const kSizeProductImageHeight = 70.0;
const kWidthDateTime = 75.0;
const kDefaultGuildId = '00000000-0000-0000-0000-000000000000';
const kEmptyProductList =
    'Không có sản phẩm.Vui lòng bấm dấu + để thêm sản phẩm mới';
const kSizeIconAddButton = 50.0;
const kWidthDropdown = 200.0;
BoxDecoration kBoxDecorationTable = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  border: Border.fromBorderSide(
    BorderSide(
      color: Colors.white.withOpacity(0.2),
      width: 4,
    ),
  ),
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF004E92),
      Color(0xFF000428),
    ],
  ),
);
BoxDecoration kBoxDecorationFilter = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        kPrimaryColor,
        kPrimaryLightColor,
      ],
    ),
    border: Border.all(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.circular(10.0));
