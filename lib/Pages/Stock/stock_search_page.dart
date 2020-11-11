import 'package:dms_admin/Data/api_helper.dart';

import 'package:dms_admin/Models/stock.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class StockSearchPage extends StatelessWidget {
  final Function(Stock selectedStock) savedData;
  StockSearchPage({Key key, this.savedData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      child: Text('abc'),
    );
  }
}

// class StockSearchPage extends StatefulWidget {
//   final Function(Stock selectedStock) savedData;
//   StockSearchPage({Key key, this.savedData}) : super(key: key);

//   @override
//   _StockSearchPageState createState() => _StockSearchPageState();
// }

// class _StockSearchPageState extends State<StockSearchPage> {
//   var _checkedStock = new Stock();
//   Future<List<Stock>> stocks;
//   @override
//   void initState() {
//     super.initState();
//     stocks = API_HELPER.listStocks();
//   }

//   Widget get _buildAPI {
//     return FutureBuilder<List<Stock>>(
//       future: stocks,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.separated(
//               separatorBuilder: (context, index) {
//                 return Divider();
//               },
//               shrinkWrap: true,
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 return _buildRow(context, index, snapshot.data[index]);
//               });
//         } else if (snapshot.hasError) {
//           return Center(child: Text("${snapshot.error}"));
//         } else
//           return Center(child: CircularProgressIndicator());
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 300.0,
//         height: double.infinity,
//         child: Column(
//           children: [
//             // MyTextField(
//             //   text: "",
//             //   title: "Tìm sản phẩm",
//             //   onChangedText: (textValue) {},
//             // ),
//             // _buildHeader,
//             Expanded(child: _buildAPI),
//             RaisedButton(
//               child: Icon(
//                 Icons.done,
//                 color: Colors.white,
//               ),
//               color: kPrimaryColor,
//               onPressed: () {
//                 setState(() {
//                   widget.savedData(_checkedStock);
//                   Navigator.pop(context);
//                 });
//               },
//             )
//           ],
//         ));
//   }

//   Widget get _buildHeader {
//     return Row(
//       children: [
//         Container(
//           width: 40,
//         ),
//         Expanded(
//           child: Text("Tên kho"),
//         ),
//       ],
//     );
//   }

//   Widget _buildRow(BuildContext context, int index, Stock stock) {
//     final color = index % 2 == 0 ? Colors.red : Colors.blue;
//     final isChecked = stock == _checkedStock;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if (isChecked) {
//             // _checkedStock = new Stock();
//           } else {
//             _checkedStock = stock;
//           }
//         });
//       },
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             child: Icon(
//               isChecked ? Icons.check_box : Icons.check_box_outline_blank,
//               color: color,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               stock.name,
//               style: TextStyle(color: color),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
