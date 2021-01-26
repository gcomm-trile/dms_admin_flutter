import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/modules/product/product_detail_page.dart';
import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  static const String routeName = "/product";
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> products;
  List<Product> originalProducts = <Product>[];
  List<Product> searchProducts = <Product>[];

  final formatter = new NumberFormat("#,###");

  TextEditingController editingController = TextEditingController();

  Widget get _searchSection {
    return TextField(
      controller: editingController,
      onChanged: onSearchTextChanged,
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }

  _getRequests() async {
    log("refresh page");
    setState(() {
      products = API_HELPER.getProduct();
    });
  }

  @override
  void initState() {
    super.initState();
    products = API_HELPER.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Products"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder<List<Product>>(
          future: products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              originalProducts = snapshot.data;
              if (editingController.text.isEmpty) {
                searchProducts = originalProducts;
              } else {
                searchProducts = originalProducts
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(editingController.text.toLowerCase()))
                    .toList();
              }
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  _searchSection,
                  Expanded(child: _buildRowSearch(searchProducts))
                ]),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildRowSearch(List<Product> data) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2.0,
          );
        },
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                log("item search selected");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailPage(data[index])),
                ).then((value) => _getRequests());
              },
              child: Container(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data[index].imagePath,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      width: 100,
                      height: 100,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].name,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        SizedBox(
                          height: 4,
                        ),
                        Text(data[index].no,
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Giá : " +
                                formatter.format(data[index].orderPrice) +
                                " đ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.green))
                      ],
                    )),
                  ],
                ),
              ));
        });
  }

  void onSearchTextChanged(String value) async {
    if (value.isNotEmpty) {
      setState(() {
        searchProducts = originalProducts
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        searchProducts = originalProducts.where((element) => 1 == 1).toList();
      });
    }
    return;

    // _userDetails.forEach((userDetail) {
    //   if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //     _searchResult.add(userDetail);
    // });
  }
}
