import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dms_admin/Models/product.dart';
import 'package:dms_admin/Pages/ProductDetail/product_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'drawer.dart';

class ProductPage extends StatefulWidget {
  static const String routeName = "/product";
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> products;
  List<Product> original_products = new List<Product>();
  List<Product> search_products = new List<Product>();

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

  Future<List<Product>> _fetchProducts() async {
    final jobsListAPIUrl = 'http://localhost/api/product';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json'
    };

    final response = await http.get(jobsListAPIUrl, headers: headers);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((product) => new Product.fromJson(product))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  void search(String query) {
    // searchList.addAll(products);
  }

  @override
  void initState() {
    super.initState();
    products = _fetchProducts();
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
              original_products = snapshot.data;

              return Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  _searchSection,
                  Expanded(
                      child: (search_products.length > 0 ||
                              editingController.text.isNotEmpty)
                          ? _buildRowSearch(search_products)
                          : _buildRowInit(original_products))
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
                );
              },
              child: Container(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data[index].image_path,
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
                                formatter.format(data[index].price) +
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

  Widget _buildRowInit(List<Product> data) {
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
                log("item init selected");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailPage(data[index])),
                );
              },
              child: Container(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data[index].image_path,
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
                            "Giá :" +
                                formatter.format(data[index].price) +
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
        search_products = original_products
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        search_products = original_products.where((element) => 1 == 1).toList();
      });
    }
    return;

    // _userDetails.forEach((userDetail) {
    //   if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
    //     _searchResult.add(userDetail);
    // });
  }
}
